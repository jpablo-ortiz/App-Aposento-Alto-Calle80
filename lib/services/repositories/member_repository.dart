import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MemberRepository {}

class MemberRepositoryImpl implements MemberRepository {
  //----------------------------------------------------------
  //--------------- VARIABLES Y CONSTRUCTOR ------------------
  //----------------------------------------------------------

  final FirebaseFirestore _firestore;

  MemberRepositoryImpl({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  //----------------------------------------------------------
  //------------------------- STREAMS ------------------------
  //----------------------------------------------------------

  Stream<List<UserApp>> getMembersStream() {
    return _firestore.collection('users').orderBy('name').snapshots().map((snapshot) => snapshot.docs.map((doc) => UserApp.fromMap(doc.data())).toList());
  }
}
