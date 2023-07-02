import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserApp extends Equatable {
  // Datos cuando el usuario ya está registrado
  final String? id;
  final String? email;
  final String? username;
  final String? photoUrl;

  // Datos que pueden estar ya antes de que el usuario esté registrado (Directorio iglesia)
  final String? names;
  final String? lastNames;
  final double? phone;
  final String? address;
  final DateTime? birthDate;

  const UserApp({
    this.id,
    this.email,
    this.username,
    this.photoUrl,
    this.names,
    this.lastNames,
    this.phone,
    this.address,
    this.birthDate,
  });

  static const empty = UserApp(
    id: '',
    email: '',
    username: null,
    photoUrl: null,
    names: null,
    lastNames: null,
    phone: null,
    address: null,
    birthDate: null,
  );

  factory UserApp.fromFirebaseUser(User? firebaseUser) {
    if (firebaseUser == null) {
      return empty;
    } else {
      return UserApp(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? "",
        username: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    }
  }

  UserApp copyWith({
    String? id,
    String? email,
    String? username,
    String? photoUrl,
    String? names,
    String? lastNames,
    double? phone,
    String? address,
    DateTime? birthDate,
  }) {
    return UserApp(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      names: names ?? this.names,
      lastNames: lastNames ?? this.lastNames,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
      'names': names,
      'lastNames': lastNames,
      'phone': phone,
      'address': address,
      'birthDate': birthDate?.millisecondsSinceEpoch,
    };
  }

  factory UserApp.fromMap(Map<String, dynamic> map) {
    return UserApp(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      names: map['names'],
      lastNames: map['lastNames'],
      phone: map['phone'],
      address: map['address'],
      birthDate: map['birthDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserApp.fromJson(String source) => UserApp.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      email,
      username,
      photoUrl,
      names,
      lastNames,
      phone,
      address,
      birthDate,
    ];
  }
}
