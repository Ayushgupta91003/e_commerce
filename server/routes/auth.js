const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');


// SIGNUP
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email });

        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exists! " });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
            // email: email bhi chalega.. both methods work.. but password mein variable name same nahi hai isiliye ye karna pada.
        });

        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({ error: e.message });
    };


    // {
    // 'name' : name, 'email' : email, 'password' : password 
    // }

    // get the data from the client
    // post that data into the database
    // return that data to the user
})

// Signin Route
// Exercise

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'User with this email does not exist!' });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: 'Incorrect Password'});
        }
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});
        // {
        // 'token' : 'tokensomething'
        // 'name' : 'Rivaan'
        // 'email' : temp@gmail.com
        // aise format mein con verdt karke de dega ye ...user._doc
        // }

    } catch (e) {
        res.status(500).json({error: e.message});
    }
})


authRouter.post('/tokenIsValid', async (req,res)=>{
    try{
        const token = req.header("x-auth-token");
        if(!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return res.json(false);

        const user = await User.findById(verified.id); 
        if(!user) return res.json(false);
        return res.json(true);
    } catch(e){
        res.status(500).json({error: e.message});
    }
})

// get user data
authRouter.get('/', auth, async (req,res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token : req.token});

})


module.exports = authRouter;

