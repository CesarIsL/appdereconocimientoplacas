import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.100.65:8000/detect_plate';

  static Future<Map<String, dynamic>> detectPlate(File imageFile) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(respStr);
      if (data['success']) {
        return {
          'text': data['text'],
          'plate_image': data['plate_image'],
          'vehiculo_info': data['vehiculo_info'], // aquí viene la info del vehículo
        };
      } else {
        return {'text': 'No detectada', 'plate_image': null, 'vehiculo_info': null};
      }
    } else {
      return {'text': 'Error en servidor', 'plate_image': null, 'vehiculo_info': null};
    }
  }
}
