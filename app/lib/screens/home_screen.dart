import 'package:flutter/material.dart';
import 'package:movie_app_2026/models/movie.dart';
import 'package:movie_app_2026/widgets/movie_card.dart';

final List<Movie> movies = [
  Movie(
    title: "The Dark Knight",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/en/1/1c/The_Dark_Knight_%282008_film%29.jpg",
    releaseYear: "2008",
    description:
        "The Dark Knight is a 2008 superhero film directed by Christopher Nolan, from a screenplay co-written with his brother Jonathan. Based on the DC Comics superhero Batman, it is the sequel to Batman Begins (2005), and the second installment in The Dark Knight trilogy. The plot follows the vigilante Batman, police lieutenant James Gordon, and district attorney Harvey Dent, who form an alliance to dismantle organized crime in Gotham City. Their efforts are derailed by the Joker, an anarchistic mastermind who seeks to test how far Batman will go to save the city from chaos. The ensemble cast includes Christian Bale, Michael Caine, Heath Ledger, Gary Oldman, Aaron Eckhart, Maggie Gyllenhaal, and Morgan Freeman.",
    rating: 9.0,
    genres: ["Action", "Crime", "Drama"],
    director: "Christopher Nolan",
    producer: "Emma Thomas",
    duration: "2h 32m",
  ),
  Movie(
    title: "Inception",
    imageUrl:
        "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg",
    releaseYear: "2010",
    description:
        "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
    rating: 8.8,
    genres: ["Action", "Adventure", "Sci-Fi"],
    director: "Christopher Nolan",
    producer: "Emma Thomas",
    duration: "2h 28m",
  ),
  Movie(
    title: "Interstellar",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkshzpfsh566sD5Im2qzFxaxfNFFqSQAFZgg&s",
    releaseYear: "2014",
    description:
        "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
    rating: 8.6,
    genres: ["Adventure", "Drama", "Sci-Fi"],
    director: "Christopher Nolan",
    producer: "Emma Thomas",
    duration: "2h 49m",
  ),
  Movie(
    title: "The Matrix",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZNl1EYS9z4PfNViNWMK_V5ZspshcWfksobw&s",
    releaseYear: "1999",
    description:
        "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
    rating: 8.7,
    genres: ["Action", "Sci-Fi"],
    director: "Lana Wachowski, Lilly Wachowski",
    producer: "Joel Silver",
    duration: "2h 16m",
  ),
  Movie(
    title: "Toy Story",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd1_9O7ZAMWdim0aZ3AGYpzugvq7EPOdJpHA&s",
    releaseYear: "1995",
    description:
        "A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy's room.",
    rating: 8.3,
    genres: ["Animation", "Adventure", "Comedy"],
    director: "John Lasseter",
    producer: "Bonnie Arnold, Ralph Guggenheim",
    duration: "1h 21m",
  ),
  Movie(
    title: "Mr. Robot",
    imageUrl:
        "https://m.media-amazon.com/images/M/MV5BOTg4NTBiZDAtZTc0YS00NzZlLTg4Y2ItNGQ3M2ZlMDM5MWQzXkEyXkFqcGc@._V1_.jpg",
    releaseYear: "2015",
    description:
        "Elliot, a brilliant but highly unstable young cyber-security engineer and vigilante hacker, becomes a key figure in a complex game of global dominance when he and his shadowy allies try to take down the corrupt corporation he is paid to protect.Elliot, a brilliant but highly unstable young cyber-security engineer and vigilante hacker, becomes a key figure in a complex game of global dominance when he and his shadowy allies try to take down the corrupt corporation he is paid to protect.",
    rating: 8.5,
    genres: ["Crime", "Drama", "Thriller"],
    director: "Sam Esmail",
    producer: "Christian Slater, Sam Esmail",
    duration: "4 Seasons",
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // columns in grid
            childAspectRatio: 0.7, // width to height ratio of each grid item
            crossAxisSpacing: 10, // horizontal spacing
            mainAxisSpacing: 10, // vertical spacing
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => MovieCard(movie: movies[index]),
        ),
      ),
    );
  }
}
