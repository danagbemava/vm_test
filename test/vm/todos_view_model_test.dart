import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:vm_test/models/todo.dart';
import 'package:vm_test/repos/todos_repo.dart';
import 'package:vm_test/services/api_service.dart';
import 'package:vm_test/view_models/todos_view_model.dart';

class MockApiService extends Mock implements ApiService {
  final MockClient _client;

  MockApiService(this._client);
}

class MockClient extends Mock implements Client {}

class MockTodoRepository extends Mock implements TodosRepo {
  final MockApiService _apiService;

  MockTodoRepository(this._apiService);
}

void main() {
  final client = MockClient();
  final apiService = MockApiService(client);
  final repo = MockTodoRepository(apiService);

  group('test getTodosMethod', () {
    final baseUrl = 'https://jsonplaceholder.typicode.com/todos';
    List<Todo> todos = [
      Todo(completed: false, id: 1, title: 'Lorem ipsum', userId: 1),
      Todo(completed: false, id: 1, title: 'Lorem ipsum', userId: 1),
      Todo(completed: false, id: 1, title: 'Lorem ipsum', userId: 1),
    ];

    test('should update todos list on success', () async {
      final vm = TodosViewModel(repo);

      when(repo.getAllTodos(baseUrl)).thenAnswer((_) async => todos);

      await vm.getTodos();

      expect(vm.todos.length, todos.length);
      expect(vm.todos.isEmpty, false);
    });

    test('should not update todos on fail', () async {
      final vm = TodosViewModel(repo);

      when(repo.getAllTodos(baseUrl))
          .thenAnswer((_) async => throw Exception('Fail'));

      await vm.getTodos();

      expect(vm.todos.length, 0);
      expect(vm.todos.isEmpty, true);
    });
  });
}
