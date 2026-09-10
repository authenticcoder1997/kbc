# Kaun Banega Crorepati

A playable KBC hot seat: 16 questions from ₹1,000 to ₹7 crore, all four lifelines
(50:50, Audience Poll, Ask the Expert, Flip the Question), padavs at ₹10,000 and
₹3,20,000, and the lock ritual before every reveal.

Play: https://authenticcoder1997.github.io/kbc/

- `index.html` — the game. Single file, no build step, no dependencies.
- `CLAUDE.md` — the game-master spec for playing the same format conversationally
  with Claude Code instead of in the browser.

Questions live in the `BANK` array in `index.html`, grouped into four difficulty
bands. Add to those arrays to extend the game.
