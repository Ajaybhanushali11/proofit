const jwt = require('jsonwebtoken');
const User = require('../models/User');

const protect = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization || '';
    if (!authHeader.startsWith('Bearer ')) {
      res.status(401);
      throw new Error('Not authorized, token missing');
    }

    const token = authHeader.split(' ')[1];
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findById(payload.id).select('-password');

    if (!user) {
      res.status(401);
      throw new Error('Not authorized');
    }

    req.user = user;
    next();
  } catch (err) {
    res.status(401);
    next(err);
  }
};

module.exports = { protect };
