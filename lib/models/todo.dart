class Todo {
  int userId;
  String title;
  bool completed;
  int id;

  Todo({this.userId, this.title, this.completed, this.id});

  factory Todo.fromJson(Map<String, dynamic> data) {
    try {
      return Todo(
        completed: data['completed'],
        title: data['title'],
        id: data['id'],
        userId: data['userId'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
