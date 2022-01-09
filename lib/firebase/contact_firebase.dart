import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_app/model/mdcontact.dart';

class ContactFirebase {
  Future<void> userSetup(
      String displayName, String email, String body, String subject) async {
    CollectionReference contact =
        FirebaseFirestore.instance.collection('Contact');
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = DateTime.now().toString();
    MDContact? mdUser = new MDContact();
    mdUser.email = email;
    mdUser.nameCus = displayName;
    mdUser.id = id;
    mdUser.subject = 'Phản hồi khách hàng';
    mdUser.body = body;
    mdUser.state = 'Chưa phản hồi';
    await contact.add(mdUser.toJson());
  }
}
