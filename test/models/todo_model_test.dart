import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vm_test/models/todo.dart';

void main() {
  group('todo model serialization', () {
    test('should return Todo model is serialized properly', () {
      final todoString = jsonEncode({
        "userId": 1,
        "id": 1,
        "title": "delectus aut autem",
        "completed": false
      });

      final res = jsonDecode(todoString);

      expect(Todo.fromJson(jsonDecode(todoString)), isA<Todo>());
      expect(res['id'], isA<int>());
      expect(res['userId'], isA<int>());
      expect(res['title'], isA<String>());
      expect(res['completed'], isA<bool>());
    });

    test('should throw error is serialization fails', () {
      final todoString = jsonEncode({
        'userId': '1',
        'id': 1,
        'title': 'delectus aut autem',
        'completed': true,
      });

      expect(() => Todo.fromJson(jsonDecode(todoString)), throwsException);
    });
  });
}
