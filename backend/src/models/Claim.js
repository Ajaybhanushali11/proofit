const mongoose = require('mongoose');

const claimSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    claimText: { type: String, required: true },
    sourceType: {
      type: String,
      enum: ['text', 'url', 'voice'],
      default: 'text',
    },
    score: { type: Number, required: true },
    explanation: { type: [String], required: true },
    summary: { type: String, required: true },
    views: { type: Number, default: 0 },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Claim', claimSchema);
