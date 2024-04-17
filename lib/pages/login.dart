import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
   
   final TextEditingController _emailcontroller = TextEditingController();
   final TextEditingController _passwordcontroller = TextEditingController();

   final void Function()? onTap ;

  
    LoginPage(
      {
        super.key,
        required this.onTap,
        });

   void login(BuildContext context) async{
     // will be done:::::
  final authservice = Authservice();     
   
   //try login
   try{
     await authservice.signInWithEmailAndPassword(_emailcontroller.text, _passwordcontroller.text);
     }
   catch(e){
    showDialog(context: context , builder: (context) => AlertDialog(
      title: Text("Invalid login id"),
    ));
   }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message_outlined,
              size: 65,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
             
             SizedBox(height: 40,),

            //welcome text
            Text("Welcome to chatting,do chat more",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 17,
            ),),
      
            SizedBox(height: 40,),
      
            //email form 
           MyTextField(
            hinttext: "Email id",
            obscure: false,
            controller: _emailcontroller,
           ),
      
           SizedBox(height: 25,),
           
            //passwrod form 
           MyTextField(
            hinttext: "Password",
            obscure: true,
            controller: _passwordcontroller,
           ),

           SizedBox(height: 30,),
      
            //login button

            Mybutton(
              text: "Login",
              onTap: () => login(context),
              ),

              SizedBox(height: 10,),

      
            //register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No account? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register Now",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}