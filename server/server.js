const express = require("express");
const mongoose = require("mongoose");

require("dotenv").config();

const port = process.env.PORT;

mongoose
    .connect(process.env.MONGO_URI,{})
    .then(() =>{
        console.log("Connected to MongoDB");
    })
    .catch((err) => {
        console.log("Error connecting to MongoDB: ", err);
    });

const app = express();
app.use(express.json());
app.use(express.urlencoded({extended: true}));


app.listen(port, () =>{
    console.log(`Server is running on port ${port}`);
});
