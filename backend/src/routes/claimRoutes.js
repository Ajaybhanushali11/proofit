const express = require('express');
const { protect } = require('../middleware/authMiddleware');
const { verifyClaim, getHistory, getTrending } = require('../controllers/claimController');

const router = express.Router();

router.post('/verify', protect, verifyClaim);
router.get('/history', protect, getHistory);
router.get('/trending', protect, getTrending);

module.exports = router;
