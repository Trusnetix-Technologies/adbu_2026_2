const mongoose = require("mongoose");
const Movie = mongoose.model("movies");

// HTTP REQUEST EXAMPLES(CRUD OPERATIONS): GET, POST, PUT, DELETE

module.exports = (app) => {
  // GET REQUEST(using express) || Read Movies
  app.get("/api/v1/get/movies", async (req, res) => {
    console.log("GET MOVIES");

    try {
      const response = await Movie.find();
      res.status(201).json({ message: "Fetched Movies: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  // POST REQUEST || Add a New Movie
  app.post("/api/v1/add/movie", async (req, res) => {
    console.log("ADD A NEW MOVIE");

    // Declare the data received in the body of the request
    const { name, image, description } = req.body;

    try {
      const movie = await Movie.findOne({ name }); // Check if the user already exists
      if (movie) {
        res.status(400).json({ message: "Movie already exists!" });
      }

      movieFields = {
        name,
        image,
        description,
      };

      const response = await Movie.create(movieFields);

      res.status(201).json({ message: "Added a New Movie: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  // PUT REQUEST || Update Movie Details
  app.put("/api/v1/update/movie/:id", async (req, res) => {
    console.log("UPDATE MOVIE");

    // Declare the data received in the body of the request
    const { id } = req.params;
    const { name, image, description } = req.body;

    try {
      const response = await Movie.updateOne(
        { _id: id },
        { name, image, description },
      );

      res.status(201).json({ message: "Updated: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
  
  // DELETE REQUEST || Delete a Movie
  app.delete("/api/v1/delete/movie/:id", async (req, res) => {
    const { id } = req.params;

    try {
      const response = await Movie.findByIdAndDelete(id);

      res.status(200).json({ message: "Deleted: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
};

// DB
//  SQL
//      MySQL, MariaDB
//          Tables | Rows
//  NoSQL
//      MongoDB
//          Collections | Documents
