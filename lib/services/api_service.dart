import 'package:http/http.dart';
import 'package:vm_test/mixins/logger_mixin.dart';

class ApiService with LoggerMixin<ApiService> {
  final Client client;

  ApiService({this.client});

  Future<Response> doPost(String url, Map<String, dynamic> body) async {
    try {
      final res = await client.post(url, body: body);

      return res;
    } on Exception {
      throw Exception('Something went wrong');
    }
  }

  Future<Response> doGet(String url) async {
    try {
      final res = await client.get(url);

      if (res.statusCode == 200) {
        return res;
      } else {
        throw Exception("Something went wrong");
      }
    } on Exception {
      throw Exception('Something went wrong');
    }
  }
}
