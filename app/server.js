const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;

// === Body parser middleware ===
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// === Serve static files from the app folder ===
app.use(express.static(__dirname));

// === Serve index.html for the root route ===
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// === MongoDB configuration ===
// Use environment variable or default to local
const mongoUrl =
  process.env.MONGO_URL || "mongodb://admin:password@localhost:27017";

const mongoClientOptions = { useNewUrlParser: true, useUnifiedTopology: true };
const databaseName = "my-db";

// === Update user profile ===
app.post('/update-profile', async (req, res) => {
  const userObj = req.body;
  try {
    const client = await MongoClient.connect(mongoUrl, mongoClientOptions);
    const db = client.db(databaseName);

    userObj['userid'] = 1;
    const myquery = { userid: 1 };
    const newvalues = { $set: userObj };

    await db.collection('users').updateOne(myquery, newvalues, { upsert: true });
    client.close();

    res.send(userObj);
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Database error' });
  }
});

// === Get user profile ===
app.get('/get-profile', async (req, res) => {
  try {
    const client = await MongoClient.connect(mongoUrl, mongoClientOptions);
    const db = client.db(databaseName);

    const result = await db.collection('users').findOne({ userid: 1 });
    client.close();

    res.send(result || {});
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: 'Database error' });
  }
});

// === Start server ===
app.listen(PORT, () => {
  console.log(`App listening on http://localhost:${PORT}`);
});