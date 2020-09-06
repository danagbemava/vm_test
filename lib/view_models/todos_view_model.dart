import 'package:vm_test/models/todo.dart';
import 'package:vm_test/repos/todos_repo.dart';
import 'package:vm_test/view_models/base_change_notifier.dart';

class TodosViewModel extends BaseChangeNotifier<TodosViewModel> {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  final TodosRepo _repo;

  TodosViewModel(this._repo);

  Future<void> getTodos() async {
    final url = 'https://jsonplaceholder.typicode.com/todos';

    try {
      final res = await _repo.getAllTodos(url);

      setState(() => _todos = res);
    } catch (e) {
      logError('getTodos', e);
    }
  }
}
