import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app_2026/models/movie.dart';
import 'package:movie_app_2026/providers/auth_provider.dart';
import 'package:movie_app_2026/providers/movie_provider.dart';
import 'package:movie_app_2026/widgets/movie_form_sheet.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: false,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              if (authProvider.isAuthenticated) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => MovieFormSheet(movie: movie),
                        );
                      },
                      icon: Icon(Icons.edit_rounded),
                      tooltip: "Edit Movie",
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Delete Movie"),
                            content: Text(
                              "Are you sure you want to delete ${movie.title}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(ctx);
                                  if (movie.id != null) {
                                    await Provider.of<MovieProvider>(
                                      context,
                                      listen: false,
                                    ).deleteMovie(movie.id!);
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Text("Delete Movie"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_rounded),
                      tooltip: "Delete Movie",
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  movie.imageUrl,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    child: Hero(
                      tag: movie.imageUrl,
                      child: Image.network(
                        movie.imageUrl,
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    movie.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rating",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          buildStarRating(movie.rating),
                          Text(
                            "${movie.rating}/10",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duration",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        movie.duration,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Director",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        movie.director,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Producer",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        movie.producer,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Release Year",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        movie.releaseYear,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Genres",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.genres.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 120,
                          child: Card(
                            child: Center(
                              child: Text(
                                movie.genres[index],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Watch Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStarRating(double rating) {
    final double startRating = rating / 2;

    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= startRating) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (index + 0.5 <= startRating) {
          return const Icon(Icons.star_half, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }
}
