import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:vm_test/models/todo.dart';
import 'package:vm_test/repos/todos_repo.dart';
import 'package:vm_test/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

class MockClient extends Mock implements Client {}

void main() {
  final apiService = MockApiService();
  final repo = TodosRepo(apiService);

  group('test getOneTodo', () {
    final baseUrl = 'https://jsonplaceholder.typicode.com/todos/1';

    test('getOneTodo returns One Todo on success', () async {
      when(apiService.doGet(baseUrl)).thenAnswer(
        (_) async => Response(
            '{"userId": 1, "id": 1,"title": "delectus aut autem","completed": true}',
            200),
      );

      expect(await repo.getOneTodo(baseUrl), isA<Todo>());
    });

    test('should throw exception if fail', () async {
      when(apiService.doGet(baseUrl)).thenAnswer(
        (_) async => Response('404', 404),
      );

      expect(() async => await repo.getOneTodo(baseUrl), throwsException);
    });
  });

  group('test getAllTodos', () {
    final baseUrl = 'https://jsonplaceholder.typicode.com/todos';

    test('should return List<Todos> on success', () async {
      when(apiService.doGet(baseUrl)).thenAnswer(
        (_) async => Response(
            '[{"userId": 1,"id": 1,"title": "delectus aut autem","completed": false},{"userId": 1,"id": 2,"title": "quis ut nam facilis et officia qui","completed": false}]',
            200),
      );

      final res = await repo.getAllTodos(baseUrl);

      expect(res, isA<List<Todo>>());
    });

    test('should return Exception on fail', () async {
      when(apiService.doGet(baseUrl)).thenAnswer(
        (_) async => Response('404', 404),
      );

      expect(() async => await repo.getAllTodos(baseUrl), throwsException);
    });
  });
}
