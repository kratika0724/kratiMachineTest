import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main.dart';


class DocumentScannerPage extends StatefulWidget {
  const DocumentScannerPage({super.key});

  @override
  State<DocumentScannerPage> createState() => _DocumentScannerPageState();
}

class _DocumentScannerPageState extends State<DocumentScannerPage> {
  CameraController? _controller;
  File? _scannedImage;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    await Permission.camera.request();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize();
    if (mounted) setState(() {});
  }

  Future<void> captureDocument() async {
    if (!_controller!.value.isInitialized) return;

    final XFile image = await _controller!.takePicture();
    File imgFile = File(image.path);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 8.5, ratioY: 11),

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Document',
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Document',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _scannedImage = File(croppedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Document Scanner')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: captureDocument,
            child: const Text("Scan Document"),
          ),
          const SizedBox(height: 10),
          if (_scannedImage != null)
            Expanded(
              child: Image.file(_scannedImage!),
            ),
        ],
      ),
    );
  }
}
