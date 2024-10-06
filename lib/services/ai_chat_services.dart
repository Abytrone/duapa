import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiChatServices {
  var loading = false.obs;

  Future<String> sendChat({required String text}) async {
    try {
      loading(true);
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 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'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": text,
            }
          ],
        }),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('Else statement: ${response.body}');
      }
      return '';
    } catch (e) {
      print(e);
      return 'null';
    } finally {
      loading(false);
    }
  }
}
