import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/api_service.dart';
import 'widgets/plate_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detector de Placas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  String? _plateText;
  String? _plateBase64;
  Map<String, dynamic>? _vehiculoInfo;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _plateText = null;
      _plateBase64 = null;
      _vehiculoInfo = null;
    });

    final result = await ApiService.detectPlate(_image!);

    setState(() {
      _plateText = result['text'];
      _plateBase64 = result['plate_image'];
      _vehiculoInfo = result['vehiculoInfo']; // <-- info del vehículo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detector de Placas')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Tomar foto"),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 20),
              if (_plateText != null || _plateBase64 != null || _vehiculoInfo != null)
                PlateResult(
                  text: _plateText,
                  base64Image: _plateBase64,
                  vehiculoInfo: _vehiculoInfo, // <-- pasamos info del vehículo
                ),
            ],
          ),
        ),
      ),
    );
  }
}
