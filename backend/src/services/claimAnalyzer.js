const EXTREME_WORDS = ['always', 'never', 'guaranteed', '100%', 'everyone', 'nobody', 'must'];
const SUSPICIOUS_PHRASES = ['doctors hate this', 'miracle cure', 'secret trick', 'no side effects'];

const clamp = (n, min, max) => Math.min(Math.max(n, min), max);

const createSummary = (text) => {
  const cleaned = text.replace(/\s+/g, ' ').trim();
  if (cleaned.length <= 140) return cleaned;
  return `${cleaned.slice(0, 137)}...`;
};

const hasBalancedSentence = (text) => {
  const words = text.trim().split(/\s+/).filter(Boolean);
  const hasPunctuation = /[.,;:!?]/.test(text);
  return words.length >= 8 && words.length <= 35 && hasPunctuation;
};

const analyzeClaim = (text = '') => {
  const value = text.trim();
  let score = 50;
  const notes = [];

  const lower = value.toLowerCase();
  const hasExtreme = EXTREME_WORDS.some((word) => lower.includes(word));
  const hasSuspicious = SUSPICIOUS_PHRASES.some((item) => lower.includes(item));
  const hasNumbers = /\d/.test(value);
  const wordCount = value.split(/\s+/).filter(Boolean).length;
  const balanced = hasBalancedSentence(value);

  if (hasExtreme) {
    score -= 20;
    notes.push('This claim contains exaggerated language which may reduce reliability.');
  }

  if (hasNumbers) {
    score += 10;
    notes.push('The claim includes numbers or stats, which can help verification if sourced.');
  } else {
    notes.push('The claim lacks verifiable data and should be cross-checked.');
  }

  if (wordCount < 5) {
    score -= 10;
    notes.push('It is very short, so context is missing and interpretation is risky.');
  }

  if (balanced) {
    score += 10;
    notes.push('The sentence structure is more balanced, which usually improves clarity.');
  }

  if (hasSuspicious) {
    score -= 10;
    notes.push('It uses phrases often seen in misleading promotional content.');
  }

  const explanation = notes.slice(0, 3);
  if (!explanation.length) {
    explanation.push('No strong red flags found, but this still needs source validation.');
  }

  return {
    score: clamp(score, 0, 100),
    explanation,
    summary: createSummary(value),
  };
};

module.exports = { analyzeClaim };
