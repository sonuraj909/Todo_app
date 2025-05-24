import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../../../../data/repositories/todo_repository.dart';

class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoRepository());
    Get.lazyPut(() => TodoController(Get.find()));
  }
}