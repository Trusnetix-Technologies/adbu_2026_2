const express = require("express");

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.listen(5001, () => {
  console.log(`Server is running on port 5001`);
}); 
