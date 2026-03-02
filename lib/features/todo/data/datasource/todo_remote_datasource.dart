
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSource(this.firestore);

  Stream<List<TodoModel>> getTodos(String userId) {
    return firestore
        .collection('todos')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return TodoModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> addTodo(TodoModel todo) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    var todoJson = todo.toJson();
    todoJson['userId'] = userId;
    await firestore.collection('todos').add(todoJson);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}
