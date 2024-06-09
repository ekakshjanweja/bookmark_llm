import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bookmark_llm/core/models/bookmark_model.dart';
import 'package:bookmark_llm/core/models/collection_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String seed;
  final String? photoUrl;
  final List<BookmarkModel> bookmarks;
  final List<CollectionModel> collections;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.seed,
    required this.photoUrl,
    required this.bookmarks,
    required this.collections,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? seed,
    String? photoUrl,
    List<BookmarkModel>? bookmarks,
    List<CollectionModel>? collections,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      seed: seed ?? this.seed,
      photoUrl: photoUrl ?? this.photoUrl,
      bookmarks: bookmarks ?? this.bookmarks,
      collections: collections ?? this.collections,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'seed': seed,
      'photoUrl': photoUrl,
      'bookmarks': bookmarks.map((x) => x.toMap()).toList(),
      'collections': collections.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      seed: map['seed'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      bookmarks: List<BookmarkModel>.from(
        (map['bookmarks'] as List<int>).map<BookmarkModel>(
          (x) => BookmarkModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      collections: List<CollectionModel>.from(
        (map['collections'] as List<int>).map<CollectionModel>(
          (x) => CollectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, seed: $seed, photoUrl: $photoUrl, bookmarks: $bookmarks, collections: $collections)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.seed == seed &&
        other.photoUrl == photoUrl &&
        listEquals(other.bookmarks, bookmarks) &&
        listEquals(other.collections, collections);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        seed.hashCode ^
        photoUrl.hashCode ^
        bookmarks.hashCode ^
        collections.hashCode;
  }
}
