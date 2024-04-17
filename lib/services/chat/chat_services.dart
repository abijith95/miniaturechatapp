import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get instance of the firestore:::
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((docs) {
        //get through the individual user::::
        final user = docs.data();

        //return user;
        return user;
      }).toList();
    });
  }

  // send message::::::::::::::::
  Future<void> sendMessage(String recieverId, message) async {
    //get into current loggedIn User::::::::::::
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUseremail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message:::::
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUseremail,
        message: message,
        receiverId: recieverId,
        timestamp: timestamp);

    //construct chat room id for the users
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); //sorting indicates that the 2 people chatting have the same id needed::::::
    String chatRoomId = ids.join('_');

    // add mssg to db::::
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages :::::
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    //construct a chatroom Id for the users:::::

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
