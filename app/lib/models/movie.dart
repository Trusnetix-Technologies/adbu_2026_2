class Movie {
  final String? id;
  final String title;
  final String imageUrl;
  final String releaseYear;
  final String description;
  final double rating;
  final List<String> genres;
  final String director;
  final String producer;
  final String duration;

  Movie({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseYear,
    required this.description,
    required this.rating,
    required this.genres,
    required this.director,
    required this.producer,
    required this.duration,
  });

  // fromJson: Create a movie object from json data we get from our API
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      releaseYear: json['releaseYear'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      genres: List<String>.from(json['genres']),
      director: json['director'],
      producer: json['producer'],
      duration: json['duration'],
    );
  }
  // toJson: converts a movie object back to json to send back to our API (for ADD/UPDATE)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'releaseYear': releaseYear,
      'description': description,
      'rating': rating,
      'genres': genres,
      'director': director,
      'producer': producer,
      'duration': duration,
    };
  }
}
