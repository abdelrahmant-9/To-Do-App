
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/profile_screen.dart';
import 'package:todo_app/features/todo/presentation/viewmodels/todo_viewmodel.dart';
import 'package:todo_app/features/todo/presentation/views/add_todo_screen.dart';
import 'package:todo_app/features/todo/presentation/views/detail_todo_screen.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      if (authViewModel.user != null) {
        Provider.of<TodoViewModel>(context, listen: false)
            .getTodos(authViewModel.user!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/mobile_tech.png', // Make sure you have this image
                      height: 40,
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: AppColors.text, size: 30),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Todo List
              Expanded(
                child: Consumer<TodoViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (viewModel.error != null) {
                      return Center(child: Text('Error: ${viewModel.error}'));
                    }

                    if (viewModel.todos.isEmpty) {
                      return const Center(child: Text('No todos yet. Add one!'));
                    }

                    return ListView.builder(
                      itemCount: viewModel.todos.length,
                      itemBuilder: (context, index) {
                        final todo = viewModel.todos[index];
                        return TodoItemCard(
                          todo: todo,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailTodoScreen(todo: todo),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 0.0,
            child: FloatingActionButton(
              heroTag: 'theme',
              onPressed: () {
                // TODO: Implement theme change
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.color_lens_outlined, color: AppColors.white),
              shape: const CircleBorder(),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 0.0,
            child: FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddTodoScreen(),
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.white, size: 30),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
