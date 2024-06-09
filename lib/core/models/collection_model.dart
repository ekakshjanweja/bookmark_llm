import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bookmark_llm/core/models/bookmark_model.dart';

class CollectionModel {
  final String collectionId;
  final String name;
  final String userId;
  final List<BookmarkModel> bookmarks;

  CollectionModel({
    required this.collectionId,
    required this.name,
    required this.userId,
    required this.bookmarks,
  });

  CollectionModel copyWith({
    String? collectionId,
    String? name,
    String? userId,
    List<BookmarkModel>? bookmarks,
  }) {
    return CollectionModel(
      collectionId: collectionId ?? this.collectionId,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collectionId': collectionId,
      'name': name,
      'userId': userId,
      'bookmarks': bookmarks.map((x) => x.toMap()).toList(),
    };
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      collectionId: map['collectionId'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      bookmarks: List<BookmarkModel>.from(
        (map['bookmarks'] as List<int>).map<BookmarkModel>(
          (x) => BookmarkModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionModel.fromJson(String source) =>
      CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectionModel(collectionId: $collectionId, name: $name, userId: $userId, bookmarks: $bookmarks)';
  }

  @override
  bool operator ==(covariant CollectionModel other) {
    if (identical(this, other)) return true;

    return other.collectionId == collectionId &&
        other.name == name &&
        other.userId == userId &&
        listEquals(other.bookmarks, bookmarks);
  }

  @override
  int get hashCode {
    return collectionId.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        bookmarks.hashCode;
  }
}
