import 'package:chatapp/components/usertile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  //chat and authservices::::
  final ChatServices _chatServices = ChatServices();
  final Authservice _authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("Home"),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }


  //Build the list of users except the current user logged in::::
  Widget _buildUserList()
  {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
       builder: (context,snapshot){
          //error check
           if(snapshot.hasError)
           {
            return Text("Error in data");
           }

          //loading data::
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Text("L O A D I N G . . . ");
          }

          return ListView(
            children:snapshot.data!
            .map<Widget>((userData) => _buildUserListitem(userData,context))
            .toList(),
          );


          //return List:::
       });
  }


  //widget for building individual list item::::
  Widget _buildUserListitem(Map<String,dynamic> userData,BuildContext context){
    //display all user except the current user::::::::::::::
    if(userData["email"] != _authservice.getCurrentUser()!.email )
    {
      return UserTile(
      text: userData['email'] ,
      onTap: (){
          //to go to chat page::
          Navigator.push(context, MaterialPageRoute(builder: (context) => 
          ChatPage(
            receivedId: userData['uid'],
             receivedEmail: userData['email'],
          ),));
      },
    );
    }
    else{
      return Container();
    }
  }
}