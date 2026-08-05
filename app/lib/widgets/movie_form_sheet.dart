import 'package:flutter/material.dart';
import 'package:movie_app_2026/models/movie.dart';
import 'package:movie_app_2026/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieFormSheet extends StatefulWidget {
  final Movie? movie;

  const MovieFormSheet({super.key, this.movie});

  @override
  State<MovieFormSheet> createState() => _MovieFormSheetState();
}

class _MovieFormSheetState extends State<MovieFormSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _genresController = TextEditingController();

  double _rating = 0.0;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _releaseYearController.dispose();
    _descriptionController.dispose();
    _directorController.dispose();
    _producerController.dispose();
    _durationController.dispose();
    _genresController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _imageUrlController.text = widget.movie!.imageUrl;
      _releaseYearController.text = widget.movie!.releaseYear;
      _descriptionController.text = widget.movie!.description;
      _directorController.text = widget.movie!.director;
      _producerController.text = widget.movie!.producer;
      _durationController.text = widget.movie!.duration;

      _genresController.text = widget.movie!.genres.join(',');
      _rating = widget.movie!.rating;
    }

    _imageUrlController.addListener(() {
      setState(() {});
    });
  }

  void _saveMovie() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final List<String> genresList = _genresController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final newMovie = Movie(
      id: widget.movie?.id, // keep the old id if editing
      title: _titleController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      releaseYear: _releaseYearController.text.trim(),
      description: _descriptionController.text.trim(),
      rating: _rating,
      genres: genresList,
      director: _directorController.text.trim(),
      producer: _producerController.text.trim(),
      duration: _durationController.text.trim(),
    );

    final provider = Provider.of<MovieProvider>(context, listen: false);

    if (widget.movie == null) {
      await provider.addMovie(newMovie);
    } else {
      await provider.updateMovie(widget.movie!.id!, newMovie);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.movie == null ? "Add Movie" : "Edit Movie",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // image preview
                      if (_imageUrlController.text.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            _imageUrlController.text.trim(),
                            height: 200,
                            width: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // title
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),

                      const SizedBox(height: 12),

                      // image url
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'Image Url',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),

                      const SizedBox(height: 12),

                      // description
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child:
                                // release year
                                TextFormField(
                                  controller: _releaseYearController,
                                  decoration: InputDecoration(
                                    labelText: 'Release Year',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                                ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child:
                                // duration
                                TextFormField(
                                  controller: _durationController,
                                  decoration: InputDecoration(
                                    labelText: 'Duration',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // genres
                      TextFormField(
                        controller: _genresController,
                        decoration: InputDecoration(
                          labelText: 'Genres',
                          hintText: 'Action, Drama, Sci-fi ....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child:
                                // director
                                TextFormField(
                                  controller: _directorController,
                                  decoration: InputDecoration(
                                    labelText: 'Director',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                                ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child:
                                // producer
                                TextFormField(
                                  controller: _producerController,
                                  decoration: InputDecoration(
                                    labelText: 'Producer',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Text(
                            'Rating: ${_rating.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: _rating,
                              min: 0,
                              max: 10,
                              divisions: 40,
                              onChanged: (value) {
                                setState(() {
                                  _rating = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _saveMovie,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.movie == null ? "Add Movie" : "Update Movie",
                        ),
                      ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
