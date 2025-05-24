import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/todo_model.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_item.dart';
import '../widgets/add_todo_dialog.dart';

class TodoScreen extends StatelessWidget {
  final TodoController _todoController = Get.find();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTodoDialog(context),
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: _todoController.todos.length,
        itemBuilder: (context, index) {
          final todo = _todoController.todos[index];
          return TodoItem(
            todo: todo,
            onToggle: (isCompleted) {
              _todoController.toggleTodoStatus(todo.id);
            },
            onDelete: () {
              _todoController.removeTodo(todo.id);
            },
            onEdit: () => _showEditTodoDialog(context, todo),
          );
        },
      )),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        onAdd: (title) {
          _todoController.addTodo(title);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        initialValue: todo.title,
        onAdd: (newTitle) {
          final updatedTodo = todo.copyWith(title: newTitle);
          _todoController.updateTodo(updatedTodo);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}