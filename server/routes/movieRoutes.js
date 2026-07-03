// HTTP REQUEST EXAMPLES(CRUD OPERATIONS): GET, POST, PUT, DELETE

module.exports = (app) => {
  // GET REQUEST(using express)
  app.get("/api/v1/get/movies", async (req, res) => {
    console.log("GET MOVIES");

    var movies = "Superman 2";

    try {
      const response = await movies;
      res.status(201).json({ message: "Fetched Movies", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  // Add a New Movie
  app.post("/api/v1/add/movie", async (req, res) => {
    console.log("ADD A NEW MOVIE");

    const { name } = req.body;

    try {
      console.log("Name: ", name);
      res.status(201).json({ message: "Added a New Movie: ", name });
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