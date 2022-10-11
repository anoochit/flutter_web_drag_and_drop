import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey.shade200,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DropzoneView(
                operation: DragOperation.copy,
                cursor: CursorType.grab,
                onCreated: (DropzoneViewController ctrl) => controller = ctrl,
                onLoaded: () => log("loaded"),
                onError: (value) => log('error = $value'),
                onHover: () => log("drop hovered"),
                onDrop: (value) async {
                  log('name =  ${(await controller.getFilename(value))}');
                  log('size =  ${(await controller.getFileSize(value))}');
                  log('mime =  ${(await controller.getFileMIME(value))}');
                },
                onDropMultiple: (value) {
                  value?.forEach((value) async {
                    log('name =  ${(await controller.getFilename(value))}');
                    log('size =  ${(await controller.getFileSize(value))}');
                    log('mime =  ${(await controller.getFileMIME(value))}');
                  });
                },
                onLeave: () => log('Zone left'),
              ),
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Drop file here or browse"),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      // browse file
                      List<dynamic> files = await controller.pickFiles();
                      files.forEach((value) async {
                        log('name =  ${(await controller.getFilename(value))}');
                        log('size =  ${(await controller.getFileSize(value))}');
                        log('mime =  ${(await controller.getFileMIME(value))}');
                      });
                    },
                    child: Text("Browse..."),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
