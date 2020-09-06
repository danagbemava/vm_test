import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:vm_test/services/api_service.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('test api service get', () {
    final client = MockClient();
    final baseUrl = 'https://jsonplaceholder.typicode.com/todos';
    final service = ApiService(client: client);

    test('should return response on success', () async {
      when(client.get(baseUrl)).thenAnswer((_) async => Response('[]', 200));

      expect(await service.doGet(baseUrl), isA<Response>());
    });

    test('should return "something went wrong on error"', () {
      when(client.get(baseUrl))
          .thenAnswer((_) async => Response("Something Went Wrong", 404));

      expect(service.doGet(baseUrl), throwsException);
    });
  });
}
