const express = require('express');
const path = require('path');
const app = express();

app.use('/', express.static(path.join(__dirname, 'public')))
app.listen(3005, () => console.log('Mock dns listening on port 3005!'))

