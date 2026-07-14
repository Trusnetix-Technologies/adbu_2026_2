class Movie {
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
}
