const express = require('express');
const basicAuth = require('basic-auth');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Simple authentication middleware
const auth = (req, res, next) => {
    const user = basicAuth(req);
    
    // Get credentials from environment variables or use defaults
    const validUser = process.env.AUTH_USER || 'viernes';
    const validPass = process.env.AUTH_PASS || 'admin123';
    
    if (!user || user.name !== validUser || user.pass !== validPass) {
        res.set('WWW-Authenticate', 'Basic realm="Mission Control"');
        return res.status(401).send('Authentication required');
    }
    
    next();
};

// Apply auth to all routes
app.use(auth);

// Serve static files
app.use(express.static(path.join(__dirname)));

// Serve dashboard.html at root
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'dashboard.html'));
});

app.listen(PORT, () => {
    console.log(`🤖 Mission Control running on port ${PORT}`);
});
