const mongoose = require("mongoose");
const { Schema } = mongoose;

const movieSchema = new Schema({
  name: { type: String },
  image: { type: String },
  description: { type: String },
});

mongoose.model("movies", movieSchema);
