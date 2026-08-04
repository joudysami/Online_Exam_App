import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final url = Uri.parse('https://exam.elevateegy.com/api/v1/questions');
  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      // 'token': 'if needed'
    });
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
  } catch (e) {
    print('Error: $e');
  }
}
