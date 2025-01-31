// Mocks generados por Mockito 5.4.5 desde las anotaciones en periferiamovies/test/helpers/test_mock.dart.
// No edites manualmente este archivo.

import 'dart:async' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter/src/widgets/framework.dart' as _i3;
import 'package:flutter/src/widgets/notification_listener.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:periferiamovies/core/core.dart' as _i7;
import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_response.dart' as _i10;
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart' as _i9;
import 'package:periferiamovies/features/movies/movies.dart' as _i8;

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeWidget_1 extends _i1.SmartFake implements _i3.Widget {
  _FakeWidget_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_2 extends _i1.SmartFake implements _i3.InheritedWidget {
  _FakeInheritedWidget_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_3 extends _i1.SmartFake implements _i4.DiagnosticsNode {
  _FakeDiagnosticsNode_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString({
    _i4.TextTreeConfiguration? parentConfiguration,
    _i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [MoviesRepository].
class MockMoviesRepository extends _i1.Mock implements _i8.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i9.Movie>>> movies(
          _i8.MoviesParams? moviesParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #movies,
          [moviesParams],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #movies,
            [moviesParams],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MoviesRemoteDatasource].
class MockMoviesRemoteDatasource extends _i1.Mock
    implements _i8.MoviesRemoteDatasource {
  MockMoviesRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i10.MovieDbResponse>> movies(
          _i8.MoviesParams? moviesParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #movies,
          [moviesParams],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i10.MovieDbResponse>>.value(
                _FakeEither_0<_i7.Failure, _i10.MovieDbResponse>(
          this,
          Invocation.method(
            #movies,
            [moviesParams],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i10.MovieDbResponse>>);
}

/// A class which mocks [BuildContext].
class MockBuildContext extends _i1.Mock implements _i3.BuildContext {
  @override
  _i3.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_1(
          this,
          Invocation.getter(#widget),
        ),
        returnValueForMissingStub: _FakeWidget_1(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i3.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i3.InheritedWidget dependOnInheritedElement(
    _i3.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_2(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
        returnValueForMissingStub: _FakeInheritedWidget_2(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i3.InheritedWidget);
}
