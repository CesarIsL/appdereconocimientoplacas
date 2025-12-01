import 'dart:convert';
import 'package:flutter/material.dart';

class PlateResult extends StatelessWidget {
  final Map<String, dynamic>? result;

  const PlateResult({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null || result!['text'] == null) {
      return const Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No se pudo detectar la placa.', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final text = result!['text'];
    final base64Image = result!['plate_image'];
    final vehiculoInfo = result!['vehiculo_info'];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Placa Detectada',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            if (base64Image != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    base64Decode(base64Image),
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 3),
              ),
            ),
            const Divider(height: 30, thickness: 1),
            if (vehiculoInfo != null)
              _buildVehiculoInfo(context, vehiculoInfo)
            else
              const Text('No se encontró información del vehículo.'),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiculoInfo(BuildContext context, Map<String, dynamic> info) {
    final propietario = info['propietario'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información del Vehículo',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildInfoTile(Icons.directions_car, 'Placa', info['placa']),
        _buildInfoTile(Icons.label, 'Marca', info['marca']),
        _buildInfoTile(Icons.model_training, 'Modelo', info['modelo']),
        _buildInfoTile(Icons.calendar_today, 'Año', info['anio'].toString()),
        const Divider(height: 30, thickness: 1),
        Text(
          'Información del Propietario',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        if (propietario != null) ...[
          _buildInfoTile(Icons.person, 'Nombre', propietario['nombre']),
          _buildInfoTile(Icons.phone, 'Teléfono', propietario['telefono']),
          _buildInfoTile(Icons.email, 'Correo', propietario['correo']),
        ] else
          const Text('No se encontró información del propietario.'),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 16)),
    );
  }
}
