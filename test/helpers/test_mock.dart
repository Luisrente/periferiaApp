import 'package:flutter/cupertino.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MoviesRepository,
  MoviesRemoteDatasource,
])
@GenerateNiceMocks([MockSpec<BuildContext>()])
void main() {}
