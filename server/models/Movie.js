const mongoose = require("mongoose");
const { Schema } = mongoose;

const movieSchema = new Schema({
  title: { type: String },
  imageUrl: { type: String },
  description: { type: String },
  releaseYear: { type: String },
  rating: { type: Number },
  genres: { type: [String] },
  director: { type: String },
  producer: { type: String },
  duration: { type: String },
});

mongoose.model("movies", movieSchema);
