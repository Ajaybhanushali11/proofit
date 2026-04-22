const express = require('express');
const cors = require('cors');

const authRoutes = require('./routes/authRoutes');
const claimRoutes = require('./routes/claimRoutes');
const { notFound, errorHandler } = require('./middleware/errorHandler');

const app = express();

app.use(cors());
app.use(express.json({ limit: '1mb' }));

app.get('/api/health', (_req, res) => {
  res.json({ ok: true, service: 'proofit-api' });
});

app.use('/api/auth', authRoutes);
app.use('/api/claim', claimRoutes);

app.use(notFound);
app.use(errorHandler);

module.exports = app;
