import 'dart:convert';

import 'package:vm_test/models/todo.dart';
import 'package:vm_test/services/api_service.dart';

class TodosRepo {
  final ApiService _apiService;

  TodosRepo(this._apiService);

  Future<Todo> getOneTodo(String url) async {
    final res = await _apiService.doGet(url);

    if (res.statusCode == 200) {
      return Todo.fromJson(jsonDecode(res.body));
    }

    throw Exception('Not found');
  }

  Future<List<Todo>> getAllTodos(String url) async {
    final res = await _apiService.doGet(url);

    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map((e) => Todo.fromJson(e))
          .toList();
    }

    throw Exception('Not found');
  }
}
