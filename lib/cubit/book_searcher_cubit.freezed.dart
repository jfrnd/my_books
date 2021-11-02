// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'book_searcher_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BookSearcherStateTearOff {
  const _$BookSearcherStateTearOff();

  _BookSearcherState call(
      {required bool isLoading,
      required bool loadingFailed,
      required List<Book> books,
      required int nextStartIndex,
      required String curQuerryKeyword}) {
    return _BookSearcherState(
      isLoading: isLoading,
      loadingFailed: loadingFailed,
      books: books,
      nextStartIndex: nextStartIndex,
      curQuerryKeyword: curQuerryKeyword,
    );
  }
}

/// @nodoc
const $BookSearcherState = _$BookSearcherStateTearOff();

/// @nodoc
mixin _$BookSearcherState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get loadingFailed => throw _privateConstructorUsedError;
  List<Book> get books => throw _privateConstructorUsedError;
  int get nextStartIndex => throw _privateConstructorUsedError;
  String get curQuerryKeyword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookSearcherStateCopyWith<BookSearcherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookSearcherStateCopyWith<$Res> {
  factory $BookSearcherStateCopyWith(
          BookSearcherState value, $Res Function(BookSearcherState) then) =
      _$BookSearcherStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool loadingFailed,
      List<Book> books,
      int nextStartIndex,
      String curQuerryKeyword});
}

/// @nodoc
class _$BookSearcherStateCopyWithImpl<$Res>
    implements $BookSearcherStateCopyWith<$Res> {
  _$BookSearcherStateCopyWithImpl(this._value, this._then);

  final BookSearcherState _value;
  // ignore: unused_field
  final $Res Function(BookSearcherState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? loadingFailed = freezed,
    Object? books = freezed,
    Object? nextStartIndex = freezed,
    Object? curQuerryKeyword = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingFailed: loadingFailed == freezed
          ? _value.loadingFailed
          : loadingFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      nextStartIndex: nextStartIndex == freezed
          ? _value.nextStartIndex
          : nextStartIndex // ignore: cast_nullable_to_non_nullable
              as int,
      curQuerryKeyword: curQuerryKeyword == freezed
          ? _value.curQuerryKeyword
          : curQuerryKeyword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BookSearcherStateCopyWith<$Res>
    implements $BookSearcherStateCopyWith<$Res> {
  factory _$BookSearcherStateCopyWith(
          _BookSearcherState value, $Res Function(_BookSearcherState) then) =
      __$BookSearcherStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool loadingFailed,
      List<Book> books,
      int nextStartIndex,
      String curQuerryKeyword});
}

/// @nodoc
class __$BookSearcherStateCopyWithImpl<$Res>
    extends _$BookSearcherStateCopyWithImpl<$Res>
    implements _$BookSearcherStateCopyWith<$Res> {
  __$BookSearcherStateCopyWithImpl(
      _BookSearcherState _value, $Res Function(_BookSearcherState) _then)
      : super(_value, (v) => _then(v as _BookSearcherState));

  @override
  _BookSearcherState get _value => super._value as _BookSearcherState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? loadingFailed = freezed,
    Object? books = freezed,
    Object? nextStartIndex = freezed,
    Object? curQuerryKeyword = freezed,
  }) {
    return _then(_BookSearcherState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingFailed: loadingFailed == freezed
          ? _value.loadingFailed
          : loadingFailed // ignore: cast_nullable_to_non_nullable
              as bool,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      nextStartIndex: nextStartIndex == freezed
          ? _value.nextStartIndex
          : nextStartIndex // ignore: cast_nullable_to_non_nullable
              as int,
      curQuerryKeyword: curQuerryKeyword == freezed
          ? _value.curQuerryKeyword
          : curQuerryKeyword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BookSearcherState implements _BookSearcherState {
  const _$_BookSearcherState(
      {required this.isLoading,
      required this.loadingFailed,
      required this.books,
      required this.nextStartIndex,
      required this.curQuerryKeyword});

  @override
  final bool isLoading;
  @override
  final bool loadingFailed;
  @override
  final List<Book> books;
  @override
  final int nextStartIndex;
  @override
  final String curQuerryKeyword;

  @override
  String toString() {
    return 'BookSearcherState(isLoading: $isLoading, loadingFailed: $loadingFailed, books: $books, nextStartIndex: $nextStartIndex, curQuerryKeyword: $curQuerryKeyword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookSearcherState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.loadingFailed, loadingFailed) ||
                other.loadingFailed == loadingFailed) &&
            const DeepCollectionEquality().equals(other.books, books) &&
            (identical(other.nextStartIndex, nextStartIndex) ||
                other.nextStartIndex == nextStartIndex) &&
            (identical(other.curQuerryKeyword, curQuerryKeyword) ||
                other.curQuerryKeyword == curQuerryKeyword));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      loadingFailed,
      const DeepCollectionEquality().hash(books),
      nextStartIndex,
      curQuerryKeyword);

  @JsonKey(ignore: true)
  @override
  _$BookSearcherStateCopyWith<_BookSearcherState> get copyWith =>
      __$BookSearcherStateCopyWithImpl<_BookSearcherState>(this, _$identity);
}

abstract class _BookSearcherState implements BookSearcherState {
  const factory _BookSearcherState(
      {required bool isLoading,
      required bool loadingFailed,
      required List<Book> books,
      required int nextStartIndex,
      required String curQuerryKeyword}) = _$_BookSearcherState;

  @override
  bool get isLoading;
  @override
  bool get loadingFailed;
  @override
  List<Book> get books;
  @override
  int get nextStartIndex;
  @override
  String get curQuerryKeyword;
  @override
  @JsonKey(ignore: true)
  _$BookSearcherStateCopyWith<_BookSearcherState> get copyWith =>
      throw _privateConstructorUsedError;
}
