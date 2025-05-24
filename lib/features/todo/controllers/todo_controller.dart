import 'package:get/get.dart';
import '../../../../data/models/todo_model.dart';
import '../../../../data/repositories/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository _todoRepository;
  final RxList<Todo> _todos = <Todo>[].obs;
  final RxBool isLoading = true.obs;

  TodoController(this._todoRepository);

  List<Todo> get todos => _todos;

  @override
  void onInit() async {
    super.onInit();
    await _todoRepository.init();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    isLoading(true);
    _todos.assignAll(_todoRepository.todos);
    isLoading(false);
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      createdAt: DateTime.now(),
    );
    await _todoRepository.addTodo(newTodo);
    await _loadTodos();
  }

  Future<void> toggleTodoStatus(String id) async {
    await _todoRepository.toggleTodoStatus(id);
    await _loadTodos();
  }

  Future<void> removeTodo(String id) async {
    await _todoRepository.removeTodo(id);
    await _loadTodos();
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    await _todoRepository.updateTodo(updatedTodo);
    await _loadTodos();
  }
}
