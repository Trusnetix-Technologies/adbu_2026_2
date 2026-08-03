import 'package:flutter/material.dart';
import 'package:movie_app_2026/providers/auth_provider.dart';
import 'package:movie_app_2026/providers/movie_provider.dart';
import 'package:movie_app_2026/screens/login_screen.dart';
import 'package:movie_app_2026/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        centerTitle: true,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              if (authProvider.isAuthenticated) {
                return IconButton(
                  onPressed: () => authProvider.logout(),
                  icon: const Icon(Icons.logout_rounded),
                  tooltip: "Logout",
                );
              } else {
                return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: Icon(Icons.login_rounded),
                  tooltip: "Login",
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: const CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(provider.errorMessage),
              ),
            );
          }

          if (provider.movies.isEmpty) {
            return const Center(child: Text("No movies found, Add some!"));
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // columns in grid
                childAspectRatio:
                    0.7, // width to height ratio of each grid item
                crossAxisSpacing: 10, // horizontal spacing
                mainAxisSpacing: 10, // vertical spacing
              ),
              itemCount: provider.movies.length,
              itemBuilder: (context, index) =>
                  MovieCard(movie: provider.movies[index]),
            ),
          );
        },
      ),
    );
  }
}
