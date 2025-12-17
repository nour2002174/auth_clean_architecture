import 'package:auth_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_clean_architecture/features/auth/presentation/bloc/auth_event.dart';
import 'package:auth_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Welcome to the Auth App"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed:  () async{
                    BlocProvider.of<AuthBloc>(context).add(
                    LogoutEvent(),
                  
                    );
                        await Future.delayed(Duration(milliseconds: 200));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                    
                  },
            child: Text("Log out"),
          ),
        ],
      ),
    );
  }
}