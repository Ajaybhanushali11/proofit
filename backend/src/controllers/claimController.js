const Claim = require('../models/Claim');
const { analyzeClaim } = require('../services/claimAnalyzer');

const verifyClaim = async (req, res, next) => {
  try {
    const { claimText, sourceType } = req.body;
    if (!claimText || typeof claimText !== 'string') {
      res.status(400);
      throw new Error('claimText is required');
    }

    const analysis = analyzeClaim(claimText);
    const claim = await Claim.create({
      userId: req.user._id,
      claimText,
      sourceType: sourceType || 'text',
      ...analysis,
    });

    res.status(201).json(claim);
  } catch (err) {
    next(err);
  }
};

const getHistory = async (req, res, next) => {
  try {
    const claims = await Claim.find({ userId: req.user._id }).sort({ createdAt: -1 }).limit(50);
    res.json(claims);
  } catch (err) {
    next(err);
  }
};

const getTrending = async (_req, res, next) => {
  try {
    const claims = await Claim.find().sort({ views: -1, createdAt: -1 }).limit(10);

    // small side effect: bump view count when shown in trending list
    const ids = claims.map((item) => item._id);
    if (ids.length) {
      await Claim.updateMany({ _id: { $in: ids } }, { $inc: { views: 1 } });
    }

    res.json(claims);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  verifyClaim,
  getHistory,
  getTrending,
};
