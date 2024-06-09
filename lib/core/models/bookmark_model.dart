import 'dart:convert';

class BookmarkModel {
  final String userId;
  final String? url;
  final String? title;
  final String? description;
  final String? notes;
  final String? markdown;
  final String? collectionId;

  BookmarkModel({
    required this.userId,
    required this.url,
    required this.title,
    required this.description,
    required this.notes,
    required this.markdown,
    required this.collectionId,
  });

  BookmarkModel copyWith({
    String? userId,
    String? url,
    String? title,
    String? description,
    String? notes,
    String? markdown,
    String? collectionId,
  }) {
    return BookmarkModel(
      userId: userId ?? this.userId,
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      markdown: markdown ?? this.markdown,
      collectionId: collectionId ?? this.collectionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'url': url,
      'title': title,
      'description': description,
      'notes': notes,
      'markdown': markdown,
      'collectionId': collectionId,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      userId: map['userId'] as String,
      url: map['url'] != null ? map['url'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      markdown: map['markdown'] != null ? map['markdown'] as String : null,
      collectionId:
          map['collectionId'] != null ? map['collectionId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarkModel.fromJson(String source) =>
      BookmarkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookmarkModel(userId: $userId, url: $url, title: $title, description: $description, notes: $notes, markdown: $markdown, collectionId: $collectionId)';
  }

  @override
  bool operator ==(covariant BookmarkModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.url == url &&
        other.title == title &&
        other.description == description &&
        other.notes == notes &&
        other.markdown == markdown &&
        other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        url.hashCode ^
        title.hashCode ^
        description.hashCode ^
        notes.hashCode ^
        markdown.hashCode ^
        collectionId.hashCode;
  }
}
