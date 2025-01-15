// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
// const productRouter = require("./routes/product");
// const userRouter = require("./routes/user");



// // IMPORTS FROM PACKAGES
// const express = require('express');
// const mongoose = require('mongoose');
// // IMPORTS FROM OTHER FILES
// const authRouter = require('./routes/auth.js');
// const adminRouter = require('./routes/admin.js');




// import 'package:flutter/screens/auth.dart'                  => 
// import './features/auth/screens/auth_screen.dart'                 => relative importing




// INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://ayushg:ayush123@cluster0.keyt0.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


// middle ware
// client -> middleware -> server -> client
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);


// Connections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
})


app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});
