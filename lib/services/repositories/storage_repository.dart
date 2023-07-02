import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageRepository {
  Future<CloudStorageResult> uploadImage(File imageToUpload, String title);
}

//----------------------------------------------------------
//----------------------- REPOSITORY -----------------------
//----------------------------------------------------------

class StorageRepositoryImpl implements StorageRepository {
  final FirebaseStorage _storage;

  StorageRepositoryImpl({
    FirebaseStorage? storage,
  }) : _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<CloudStorageResult> uploadImage(File imageToUpload, String title) async {
    String imageFileName = title; //+ DateTime.now().millisecondsSinceEpoch.toString();

    // Get the reference to the file we want to upload
    final Reference ref = _storage.ref().child(imageFileName);

    UploadTask uploadTask = ref.putFile(imageToUpload);
    return await uploadTask.then(
      (value) async {
        var downloadUrl = await value.ref.getDownloadURL();
        return CloudStorageResult(
          imageUrl: downloadUrl,
          imageFileName: imageFileName,
        );
      },
      onError: (error) => null,
    );
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({
    required this.imageUrl,
    required this.imageFileName,
  });

  CloudStorageResult copyWith({
    String? imageUrl,
    String? imageFileName,
  }) {
    return CloudStorageResult(
      imageUrl: imageUrl ?? this.imageUrl,
      imageFileName: imageFileName ?? this.imageFileName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
    };
  }

  factory CloudStorageResult.fromMap(Map<String, dynamic> map) {
    return CloudStorageResult(
      imageUrl: map['imageUrl'] ?? '',
      imageFileName: map['imageFileName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudStorageResult.fromJson(String source) => CloudStorageResult.fromMap(json.decode(source));

  @override
  String toString() => 'CloudStorageResult(imageUrl: $imageUrl, imageFileName: $imageFileName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CloudStorageResult && other.imageUrl == imageUrl && other.imageFileName == imageFileName;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ imageFileName.hashCode;
}
