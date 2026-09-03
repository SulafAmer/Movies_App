
import 'movie.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final List<Movie> movies;

  MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return MoviesResponse(
      status: json['status'] ?? 'error',
      statusMessage: json['status_message'] ?? '',
      movies: data != null && data['movies'] != null
          ? (data['movies'] as List).map((m) => Movie.fromJson(m)).toList()
          : [],
    );
  }

  bool get isOk => status == 'ok';
}