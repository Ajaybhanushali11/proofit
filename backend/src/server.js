const dotenv = require('dotenv');
dotenv.config({path:'../.env.example'});

const app = require('./app');
const connectDb = require('./config/db');

const PORT = process.env.PORT || 5000;

const boot = async () => {
  await connectDb();
  app.listen(PORT, () => {
    console.log(`API running on ${PORT}`);
  });
};

boot();
