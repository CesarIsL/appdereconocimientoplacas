import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.100.65:8000/detect_plate';

  static Future<Map<String, dynamic>> detectPlate(File imageFile) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_baseUrl))
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      return _handleResponse(response);
    } catch (e) {
      // Handle exceptions such as no internet connection
      return {
        'success': false,
        'text': 'Error de conexión: $e',
        'plate_image': null,
        'vehiculo_info': null,
      };
    }
  }

  static Future<Map<String, dynamic>> _handleResponse(http.StreamedResponse response) async {
    final respStr = await response.stream.bytesToString();
    
    if (response.statusCode == 200) {
      final data = json.decode(respStr);
      if (data['success']) {
        return {
          'success': true,
          'text': data['text'],
          'plate_image': data['plate_image'],
          'vehiculo_info': data['vehiculo_info'],
        };
      } else {
        return {'success': false, 'text': data['message'] ?? 'No se detectó la placa.', 'plate_image': null, 'vehiculo_info': null};
      }
    } else {
      // Handle other status codes like 500, 404, etc.
      return {
        'success': false,
        'text': 'Error del servidor (código: ${response.statusCode})',
        'plate_image': null,
        'vehiculo_info': null,
      };
    }
  }
}
