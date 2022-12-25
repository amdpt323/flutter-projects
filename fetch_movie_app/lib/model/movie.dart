import 'dart:convert';

class Movie{

  final bool ? adult;
  final String ? backdropPath;
  final int  ? id;
  final String ? originalLanguage;
  final String ? originalTitle;
  final String ? overview;
  final double ? popularity;
  final String ? posterPath;
  final DateTime ? releaseDate;
  final String ? title;
  final bool ? video;
  final double ? voteAverage;
  final int ? voteCount;

  String ? error;

  Movie({
    this.adult,
    this.backdropPath,
  this.originalLanguage,
  this.id,
  this.originalTitle,
  this.overview,
  this.popularity,
  this.posterPath,
  this.releaseDate,
  this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.error,
  });

  factory Movie.fromJson(dynamic json) {
    if(json == null){
      return Movie();
    }

    return Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      releaseDate: DateTime.parse(json["release_date"]),
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );

  }
}