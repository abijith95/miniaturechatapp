import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

   final TextEditingController _emailcontroller = TextEditingController();
   final TextEditingController _passwordcontroller = TextEditingController();
   final TextEditingController _confirmcontroller = TextEditingController();

   final void Function()? onTap;
   RegisterPage(
    {super.key,
     required this.onTap,
    });

   void register(BuildContext context){
    // will be done:::
            final _auth = Authservice();

      if(_passwordcontroller.text == _confirmcontroller.text){
        try{
            _auth.signUpWithEmailandPassword(
              _emailcontroller.text, 
              _passwordcontroller.text);
        }
        catch(e)
        {
          showDialog(context: context, builder: (context)=> AlertDialog(
             title: Text("Invalid information"),
          ));
        }
      }
      else{
        showDialog(context: context, builder: (contex)=> AlertDialog(title: Text("passwords does not match"),));
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
            Text("-Lets get Registered-",
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
            SizedBox(height: 25,),


            //confirm Password form 
           MyTextField(
            hinttext: " Confirm Password",
            obscure: true,
            controller: _confirmcontroller,
           ),

           SizedBox(height: 30,),
      
            //login button

            Mybutton(
              text: "Register",
              onTap: () => register(context),
              ),

              SizedBox(height: 10,),

      
            //register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Registered? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login Now",style: TextStyle(
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