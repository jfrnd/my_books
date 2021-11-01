import 'package:objectbox/objectbox.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';

@Entity()
class Book {
  @Id()
  int localId;
  String remoteId;
  String title;
  String subtitle;
  List<String> authors;

  Book({
    required this.localId,
    required this.remoteId,
    required this.title,
    required this.subtitle,
    required this.authors,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> volumeInfo = json['volumeInfo'];
    return Book(
      localId: 0,
      remoteId: json['id'],
      title: volumeInfo['title'] ?? '',
      subtitle: volumeInfo['subtitle'] ?? '',
      authors: (volumeInfo['authors'] != null
              ? volumeInfo['authors'] as List<dynamic>
              : [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
