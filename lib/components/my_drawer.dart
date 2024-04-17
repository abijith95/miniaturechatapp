import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/pages/settings.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


void logout(){
    //auth service getting::
    final auth = Authservice();
    auth.signout();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
               //logo
         DrawerHeader(child: Center(
          child: Icon(Icons.message,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 40,          
          ),
          )),

              //Home
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              title:const  Text("H O M E"),
              leading: const Icon(Icons.home),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),

            ],
          ),
                    //logout
          Padding(
            padding: const EdgeInsets.only(left: 20.0,bottom: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}