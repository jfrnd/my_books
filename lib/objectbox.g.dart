// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/book.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4429890115662481560),
      name: 'Book',
      lastPropertyId: const IdUid(5, 6880432363098805143),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3676342886212521671),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6018618505432188544),
            name: 'remoteId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 651704788904813227),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9186612423499469656),
            name: 'subtitle',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6880432363098805143),
            name: 'authors',
            type: 30,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 4429890115662481560),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Book: EntityDefinition<Book>(
        model: _entities[0],
        toOneRelations: (Book object) => [],
        toManyRelations: (Book object) => {},
        getId: (Book object) => object.id,
        setId: (Book object, int id) {
          object.id = id;
        },
        objectToFB: (Book object, fb.Builder fbb) {
          final remoteIdOffset = fbb.writeString(object.remoteId);
          final titleOffset = fbb.writeString(object.title);
          final subtitleOffset = fbb.writeString(object.subtitle);
          final authorsOffset = fbb.writeList(
              object.authors.map(fbb.writeString).toList(growable: false));
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, remoteIdOffset);
          fbb.addOffset(2, titleOffset);
          fbb.addOffset(3, subtitleOffset);
          fbb.addOffset(4, authorsOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Book(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              remoteId:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              title:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              subtitle:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              authors:
                  const fb.ListReader<String>(fb.StringReader(), lazy: false)
                      .vTableGet(buffer, rootOffset, 12, []));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Book] entity fields to define ObjectBox queries.
class Book_ {
  /// see [Book.id]
  static final id = QueryIntegerProperty<Book>(_entities[0].properties[0]);

  /// see [Book.remoteId]
  static final remoteId = QueryStringProperty<Book>(_entities[0].properties[1]);

  /// see [Book.title]
  static final title = QueryStringProperty<Book>(_entities[0].properties[2]);

  /// see [Book.subtitle]
  static final subtitle = QueryStringProperty<Book>(_entities[0].properties[3]);

  /// see [Book.authors]
  static final authors =
      QueryStringVectorProperty<Book>(_entities[0].properties[4]);
}
