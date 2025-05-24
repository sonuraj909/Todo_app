import 'package:get/get.dart';
import '../features/todo/bindings/todo_bindings.dart';
import '../features/todo/views/todo_screen.dart';


class AppPages {
  static const initial ='/todo';

  static final routes = [
    GetPage(
      name:initial,
      page: () => TodoScreen(),
      binding: TodoBinding(),
    ),
  ];
}