console.log("Hello, World!");

const express = require('express');
const PORT = 3000;

const app = express();

// creating an api
// http://<youripaddress>/hello-world

// create a get request giving a json response with the key of name and the value of your name.
// {
//     'name' : 'Ayush';
// }

app.get("/", (req,res)=>{
    res.json({"name": "Rivaan"});
})


app.get("/hello-world", (req,res) => {
    res.send("Hello World");
})



app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});
