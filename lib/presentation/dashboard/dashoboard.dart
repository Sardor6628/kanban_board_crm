import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/blocks/authentication/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/contant_variables.dart';
import 'package:kanban_board/constants/routes.dart';
import 'package:kanban_board/models/tasks.dart';
import 'package:kanban_board/presentation/dashboard/widgets/completed_task_list_widget.dart';
import 'package:kanban_board/presentation/dashboard/widgets/in_progress_task_list_widget.dart';
import 'package:kanban_board/presentation/dashboard/widgets/todo_task_list_widget.dart';
import 'package:kanban_board/widgets/add_update_widget.dart';
class Dashboard extends StatefulWidget {
  Dashboard({Key? key, this.user}) : super(key: key);
  User? user;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

@override
  void initState() {
  BlocProvider.of<TaskBloc>(context).add(TasksLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<TaskBloc>(context);
    final authController= BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Unauthenticated) {
      // Navigating to the dashboard screen if the user is authenticated
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false);
      //clean firebase auth
    }
    if (state is AuthError) {
      // Showing the error message if the user has entered invalid credentials
      Fluttertoast.showToast(msg: state.message);
    }
  },
  child: Scaffold(
        appBar: AppBar(
          title: const Text('Kanban Board', style: TextStyle(fontWeight: FontWeight.w700),),

          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          actions: [IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Logout'),
                content:  Text('${FirebaseAuth.instance.currentUser!.email} are you sure you want to logout?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('Cancel', style: TextStyle(color: Colors.grey),)),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    authController.add(SignOutRequested());
                  }, child: const Text('Logout')),
                ]);
            });
          }, icon: Icon(Icons.logout))],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BlocConsumer(
            bloc: BlocProvider.of<TaskBloc>(context),
            listener: (context, state) {
              if (state is TaskLoadFailure) {
                Fluttertoast.showToast(msg: "${state.message}");
              }
            },
            builder: (context, state) {
              if (state is TaskLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TaskLoadSuccess) {
                return StreamBuilder<List<Task>>(
                  stream: state.taskSubscription,
                  builder:
                      (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                    if (snapshot.hasData) {
                      List<Task> todoTasks = snapshot.data!
                          .where((element) =>
                      element.currentStatus == ConstantVariables.todoTask)
                          .toList();
                      List<Task> currentTasks = snapshot.data!
                          .where((element) =>
                      element.currentStatus ==
                          ConstantVariables.currentTask)
                          .toList();
                      List<Task> completedTasks = snapshot.data!
                          .where((element) =>
                      element.currentStatus ==
                          ConstantVariables.completedTask)
                          .toList();
                      return Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TodoTaskListWidget(
                                  controller: controller, tasks: todoTasks),
                              SizedBox(height: 20),
                              InProgressListWidget(
                                  controller: controller, tasks: currentTasks),
                              SizedBox(height: 20),
                              CompletedTaskListWidget(
                                  controller: controller, tasks: completedTasks),
                            ],
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                );
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>
                    AddAndUpdateTaskDialog(context: context, controller: controller));
          },
          child: const Icon(Icons.add),
        )),
);
  }



}
