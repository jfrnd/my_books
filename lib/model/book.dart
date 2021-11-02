import 'package:objectbox/objectbox.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';
import 'package:equatable/equatable.dart';

@Entity()
// ignore: must_be_immutable
class Book extends Equatable {
  @Id()
  int localId;
  final String remoteId;
  final String title;
  final String subtitle;
  final List<String> authors;
  final String description;
  final String? imageUrl;

  Book({
    required this.localId,
    required this.remoteId,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.description,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> volumeInfo = json['volumeInfo'];
    final Map<String, dynamic> imageLinks = (volumeInfo['imageLinks'] != null
        ? volumeInfo['imageLinks'] as Map<String, dynamic>
        : {'thumbnail': null});
    final List<dynamic> authors = (volumeInfo['authors'] != null
        ? volumeInfo['authors'] as List<dynamic>
        : ['']);
    return Book(
      localId: 0,
      remoteId: json['id'],
      title: volumeInfo['title'] ?? '',
      subtitle: volumeInfo['subtitle'] ?? '',
      description: volumeInfo['description'] ?? '',
      authors: authors.map((e) => e.toString()).toList(),
      imageUrl:
          imageLinks.containsKey('thumbnail') ? imageLinks['thumbnail'] : null,
    );
  }

  @override
  List<Object?> get props => [
        localId,
        remoteId,
        title,
        subtitle,
        description,
        authors,
      ];
}
