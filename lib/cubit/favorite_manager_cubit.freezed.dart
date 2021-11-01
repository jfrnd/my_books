// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'favorite_manager_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FavoriteManagerStateTearOff {
  const _$FavoriteManagerStateTearOff();

  _FavoriteManagerState call(
      {required bool isLoading, required List<Book> favoriteBooks}) {
    return _FavoriteManagerState(
      isLoading: isLoading,
      favoriteBooks: favoriteBooks,
    );
  }
}

/// @nodoc
const $FavoriteManagerState = _$FavoriteManagerStateTearOff();

/// @nodoc
mixin _$FavoriteManagerState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Book> get favoriteBooks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoriteManagerStateCopyWith<FavoriteManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteManagerStateCopyWith<$Res> {
  factory $FavoriteManagerStateCopyWith(FavoriteManagerState value,
          $Res Function(FavoriteManagerState) then) =
      _$FavoriteManagerStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<Book> favoriteBooks});
}

/// @nodoc
class _$FavoriteManagerStateCopyWithImpl<$Res>
    implements $FavoriteManagerStateCopyWith<$Res> {
  _$FavoriteManagerStateCopyWithImpl(this._value, this._then);

  final FavoriteManagerState _value;
  // ignore: unused_field
  final $Res Function(FavoriteManagerState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? favoriteBooks = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      favoriteBooks: favoriteBooks == freezed
          ? _value.favoriteBooks
          : favoriteBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc
abstract class _$FavoriteManagerStateCopyWith<$Res>
    implements $FavoriteManagerStateCopyWith<$Res> {
  factory _$FavoriteManagerStateCopyWith(_FavoriteManagerState value,
          $Res Function(_FavoriteManagerState) then) =
      __$FavoriteManagerStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, List<Book> favoriteBooks});
}

/// @nodoc
class __$FavoriteManagerStateCopyWithImpl<$Res>
    extends _$FavoriteManagerStateCopyWithImpl<$Res>
    implements _$FavoriteManagerStateCopyWith<$Res> {
  __$FavoriteManagerStateCopyWithImpl(
      _FavoriteManagerState _value, $Res Function(_FavoriteManagerState) _then)
      : super(_value, (v) => _then(v as _FavoriteManagerState));

  @override
  _FavoriteManagerState get _value => super._value as _FavoriteManagerState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? favoriteBooks = freezed,
  }) {
    return _then(_FavoriteManagerState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      favoriteBooks: favoriteBooks == freezed
          ? _value.favoriteBooks
          : favoriteBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc

class _$_FavoriteManagerState implements _FavoriteManagerState {
  const _$_FavoriteManagerState(
      {required this.isLoading, required this.favoriteBooks});

  @override
  final bool isLoading;
  @override
  final List<Book> favoriteBooks;

  @override
  String toString() {
    return 'FavoriteManagerState(isLoading: $isLoading, favoriteBooks: $favoriteBooks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FavoriteManagerState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other.favoriteBooks, favoriteBooks));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(favoriteBooks));

  @JsonKey(ignore: true)
  @override
  _$FavoriteManagerStateCopyWith<_FavoriteManagerState> get copyWith =>
      __$FavoriteManagerStateCopyWithImpl<_FavoriteManagerState>(
          this, _$identity);
}

abstract class _FavoriteManagerState implements FavoriteManagerState {
  const factory _FavoriteManagerState(
      {required bool isLoading,
      required List<Book> favoriteBooks}) = _$_FavoriteManagerState;

  @override
  bool get isLoading;
  @override
  List<Book> get favoriteBooks;
  @override
  @JsonKey(ignore: true)
  _$FavoriteManagerStateCopyWith<_FavoriteManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}
