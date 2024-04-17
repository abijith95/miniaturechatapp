import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class  Authservice{

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
 //get the current User:::::::::::::
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  //sign in
  Future<UserCredential> signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password,);

      //save user detail in seperate docs if already exist::::::::::::
         _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid' : userCredential.user!.uid,
            'email':email,
          },
         );
      return userCredential;
    }
    on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }


  //sign up
   Future<UserCredential> signUpWithEmailandPassword(String email,String password) async{
      try{
         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

         //save user detail in seperate docs :::::::::::::
         _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid' : userCredential.user!.uid,
            'email':email,
          },
         );

         return userCredential;
      }on FirebaseAuthException catch(e){
        throw Exception(e.code);
      }
   }
  //sign out
  Future<void> signout() async{
    return await _auth.signOut();
  }
  

  //errors
}