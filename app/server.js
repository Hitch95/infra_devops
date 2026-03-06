const express = require('express');

const app = express();

const PORT = process.env.PORT || 3000;
const APP_ENV = process.env.APP_ENV || 'development';
const DATABASE_URL = process.env.DATABASE_URL;

console.log(`APP_ENV: ${APP_ENV}`);
console.log(`DATABASE_URL: ${DATABASE_URL}`);

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'ok' });
});

app.get('/', (req, res) => {
    res.send(`Bienvenue ! Environment: ${APP_ENV}`);
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
