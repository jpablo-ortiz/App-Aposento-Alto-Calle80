import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  //----------------------------------------------------------
  //--------------- VARIABLES Y CONSTRUCTOR ------------------
  //----------------------------------------------------------

  final FirebaseFirestore _firestore;

  DatabaseService({
    CollectionReference? db,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  //----------------------------------------------------------
  //----------------- IMPLEMENTACIÓN ANTERIOR ----------------
  //----------------------------------------------------------

  //----------------------------------------------------------
  //--------------- VARIABLES Y CONSTRUCTOR ------------------
  //----------------------------------------------------------

  //final String uid;
  final String uid = "";
  //DatabaseService({this.uid});

  //Colección que define la base de datos (No-SQL)
  final CollectionReference db = FirebaseFirestore.instance.collection('users');

  //----------------------------------------------------------
  //------------------------- STREAMS ------------------------
  //----------------------------------------------------------

  Stream<Usuario> get usuarioActual {
    return db.doc(uid).snapshots().map(_obtenerUsuarioDeSnapshot);
  }

  Usuario _obtenerUsuarioDeSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Usuario(
      nombres: data['nombres'] ?? "",
      apellidos: data['apellidos'] ?? "",
      email: data['email'] ?? "",
      uid: data['uid'] ?? "",
    );
  }

  Stream<List<Usuario>> get usuarios {
    return db.snapshots().map(_obtenerListaUsuariosDeSnapshot);
  }

  List<Usuario> _obtenerListaUsuariosDeSnapshot(QuerySnapshot snapshot) {
    List<Usuario> a = snapshot.docs.map(
      (QueryDocumentSnapshot queryDocumentSnapshot) {
        Map<String, dynamic> data = queryDocumentSnapshot.data()! as Map<String, dynamic>;
        return Usuario(
          nombres: data['nombres'] ?? "",
          apellidos: data['apellidos'] ?? "",
          email: data['email'] ?? "",
          uid: data['uid'] ?? "",
        );
      },
    ).toList();
    return a;
  }

  //----------------------------------------------------------
  //----------------- FUNCIONES PRINCIPALES ------------------
  //----------------------------------------------------------

  Future<void> actualizarInformacionUsuario(String nombres, String apellidos, String email, String uid) async {
    return await db.doc(uid).set(
      {
        'nombres': nombres,
        'apellidos': apellidos,
        'email': email,
        'uid': uid,
      },
    );
  }
}

class Usuario {
  User? user;
  String uid;
  String nombres;
  String apellidos;
  String email;

  Usuario({
    required this.uid,
    required this.nombres,
    required this.apellidos,
    required this.email,
  });

  void setUser(User user) {
    this.user = user;
  }
}
