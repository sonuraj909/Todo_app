import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoRepository {
  late Box<Todo> _todoBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      _todoBox = await Hive.openBox<Todo>('todos');
      _isInitialized = true;
    }
  }

  List<Todo> get todos => _todoBox.values.toList();

  Future<void> addTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> removeTodo(String id) async {
    await _todoBox.delete(id);
  }

  Future<void> toggleTodoStatus(String id) async {
    final todo = _todoBox.get(id);
    if (todo != null) {
      await _todoBox.put(id, todo.copyWith(isCompleted: !todo.isCompleted));
    }
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    await _todoBox.put(updatedTodo.id, updatedTodo);
  }
}
