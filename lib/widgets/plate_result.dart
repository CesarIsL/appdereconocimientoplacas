import 'dart:convert';
import 'package:flutter/material.dart';

class PlateResult extends StatelessWidget {
  final String? text;
  final String? base64Image;
  final Map<String, dynamic>? vehiculoInfo; // nueva propiedad

  const PlateResult({super.key, this.text, this.base64Image, this.vehiculoInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (base64Image != null)
          Image.memory(
            base64Decode(base64Image!),
            width: 300,
            fit: BoxFit.contain,
          ),
        const SizedBox(height: 10),
        if (text != null)
          Text(
            'Texto OCR: $text',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 10),
        if (vehiculoInfo != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Placa: ${vehiculoInfo!['placa']}'),
              Text('Marca: ${vehiculoInfo!['marca']}'),
              Text('Modelo: ${vehiculoInfo!['modelo']}'),
              Text('Año: ${vehiculoInfo!['anio']}'),
              const SizedBox(height: 5),
              Text('Propietario: ${vehiculoInfo!['propietario']['nombre']}'),
              Text('Teléfono: ${vehiculoInfo!['propietario']['telefono']}'),
              Text('Correo: ${vehiculoInfo!['propietario']['correo']}'),
            ],
          ),
      ],
    );
  }
}
