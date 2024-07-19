import 'package:app_movie_challenge/src/features/movies/datasources/models/movies_response.dart';
import 'package:app_movie_challenge/src/features/movies/datasources/remote/movie_remote_datasource.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../../../fixtures/data/load_fixture.dart';
import '../../../../../flutter_test_config.dart';

void main() {
  final dioAdapterMock = appTestInjector.get<DioAdapter>();
  final httpClient = appTestInjector.get<AppHttpClient>();
  final dataSource = MovieRemoteDataSource(client: httpClient);
  group('Movie Features:', () {
    group('MovieRemoteDataSource:', () {
      test('getMovies: should fetch movies and return MoviesResponseModel', () async {
        // Arrange
        final data = loadFixtureFromJsonFile('remote/movies_list.json');

        dioAdapterMock.onGet(
          '',
          queryParameters: {
            'page': 1,
            'size': 10,
            'winner': true,
            'year': 2023,
          },
          (request) => request.reply(200, data),
        );

        // Act
        final result = await dataSource.getMovies(
          page: 1,
          limit: 10,
          winner: true,
          year: 2023,
        );

        // Assert
        expect(result, isA<MoviesResponseModel>());
        expect(result.content.length, equals(data['content'].length));
      });

      test(
          'maxMinWinIntervalProducers: should fetch data from API and return MinMaxWinnerIntervalProducerResponseModel',
          () async {
        // Arrange
        final data = loadFixtureFromJsonFile(
          'remote/max-min-win-interval-for-producers.json',
        );

        dioAdapterMock.onGet(
          '',
          queryParameters: {'projection': 'max-min-win-interval-for-producers'},
          (request) => request.reply(200, data),
        );

        // Act
        final result = await dataSource.maxMinWinIntervalProducers();

        // Assert
        expect(result, isA<MinMaxWinnerIntervalProducerResponseModel>());
        expect(result.max.length, equals(data['max'].length));
        expect(result.min.length, equals(data['min'].length));
      });

      test(
          'studiosWithWinCount: should fetch data from API and return MinMaxWinnerIntervalProducerResponseModel',
          () async {
        // Arrange
        final data = loadFixtureFromJsonFile(
          'remote/studios-with-win-count.json',
        );

        dioAdapterMock.onGet(
          '',
          queryParameters: {'projection': 'studios-with-win-count'},
          (request) => request.reply(200, data),
        );

        // Act
        final result = await dataSource.studiosWithWinCount();

        // Assert
        expect(result, isA<StudiosWithWinCountResponseModel>());
        expect(result.studios.length, equals(data['studios'].length));
      });

      test(
          'yearsWithMultipleWinners: should fetch data from API and return MinMaxWinnerIntervalProducerResponseModel',
          () async {
        // Arrange
        final data = loadFixtureFromJsonFile(
          'remote/years-with-multiple-winners.json',
        );

        dioAdapterMock.onGet(
          '',
          queryParameters: {'projection': 'years-with-multiple-winners'},
          (request) => request.reply(200, data),
        );

        // Act
        final result = await dataSource.yearsWithMultipleWinners();

        // Assert
        expect(result, isA<WinnerByYearResponseModel>());
        expect(result.years.length, equals(data['years'].length));
      });
    });
  });
}
