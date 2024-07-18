import 'package:app_movie_challenge/src/features/movies/datasources/remote/movie_remote_datasource.dart';
import 'package:app_movie_challenge/src/features/movies/domains/entities/movie.dart';
import 'package:app_movie_challenge/src/features/movies/domains/repositories/movies_repository.dart';
import 'package:app_movie_challenge/src/features/movies/domains/use_cases/fetch_movies_use_case.dart';
import 'package:app_movie_challenge/src/features/settings/domains/repositories/settings.dart';
import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';

import 'package:mocktail/mocktail.dart';

class MockAppLogger extends Mock implements AppLogger {}

class MockAppSettingsRepository extends Mock implements AppSettingsRepository {}

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockMoviesRepository extends Mock implements MoviesRepository {}

class MockFetchMoviesUseCase extends Mock implements FetchMoviesUseCase {}

class MockMovie extends Mock implements Movie {}

class MockMovies extends Mock implements Movies {}
