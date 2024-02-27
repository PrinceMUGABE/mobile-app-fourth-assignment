import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
        await _controller.initialize();
      } else {
        print('No cameras available');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: _buildCameraPreview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_controller != null && _controller.value.isInitialized) {
            try {
              final image = await _controller.takePicture();
              // Process the captured image
            } catch (e) {
              print('Error taking picture: $e');
            }
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_controller != null && _controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
