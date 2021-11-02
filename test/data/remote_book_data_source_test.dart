import 'package:kleine_aufgabe/apikey.dart';
import 'package:kleine_aufgabe/data/remote_book_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:kleine_aufgabe/exceptions.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/fixture_reader.dart';
import '../fixtures/response.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RemoteBookDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    registerFallbackValue(Uri());

    mockHttpClient = MockHttpClient();
    dataSource = RemoteBookDataSource(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response(fixture('response.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('', () {
    const keyword = "precht";
    final books = [bookOne, bookTwo];

    test(
      '''should perform a GET request with httpclient''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getBooks(keyword, 0);
        // assert
        verify(
          () => mockHttpClient.get(
            Uri.parse(
              'https://www.googleapis.com/books/v1/volumes?q=$keyword&maxResults=40&key=$apiKey',
            ),
          ),
        );
      },
    );

    test(
      'should return books when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getBooks(keyword, 0);
        // assert
        expect(result, equals(books));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getBooks;
        // assert
        expect(() => call(keyword, 0),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
