import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  int? id;
  String? image;
  String? description;
  String? category;
  double? latitude;
  double? longitude;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  int? userId;
  String? userFullname;

  Post({
    this.id,
    this.image,
    this.description,
    this.category,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.userFullname,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      image: doc['image'],
      description: data['description'],
      category: data['category'],
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
      latitude: data['latitude'],
      longitude: data['longitude'],
      userId: data['user_id'],
      userFullName: data['user_full_name'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'image': image,
      'description': description,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_id': userId,
      'user_full_name': userFullName,
    };
  }
}
