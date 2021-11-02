import 'package:objectbox/objectbox.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';
import 'package:equatable/equatable.dart';

@Entity()
class Book extends Equatable {
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
      title: volumeInfo['title'] ?? 'no title',
      subtitle: volumeInfo['subtitle'] ?? 'no subtitle',
      authors: (volumeInfo['authors'] != null
              ? volumeInfo['authors'] as List<dynamic>
              : ['no author'])
          .map((e) => e.toString())
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        localId,
        remoteId,
        title,
        subtitle,
        authors,
      ];
}
