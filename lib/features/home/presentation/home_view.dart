import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: AuthLocalDataSource().getToken(),
            builder: (context, data) {
              if (!data.hasData) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: Text('Logout'),
              );
            },
          ),
        ],
      ),
    );
  }
}
