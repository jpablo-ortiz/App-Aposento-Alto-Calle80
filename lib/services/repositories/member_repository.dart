import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MemberRepository {
  Stream<List<UserApp>> getMembersStream();
}

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

  @override
  Stream<List<UserApp>> getMembersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) => _orderMembers(snapshot.docs.map((doc) => UserApp.fromMap(doc.data())).toList()));
  }

  List<UserApp> _orderMembers(List<UserApp> members) {
    members.sort((a, b) => a.realUsedName.toLowerCase().compareTo(b.realUsedName.toLowerCase()));
    return members;
  }
}
