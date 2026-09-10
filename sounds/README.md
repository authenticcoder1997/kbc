# Sound pack

MP3s in this folder replace the game's built-in synthesized cues. Any file that
is absent falls back to the synth, so a partial pack works fine.

The mapping lives in the `PACK` object in `../index.html` — edit it there to
point a cue at a different file.

| cue | file | plays when |
|---|---|---|
| `theme` / `theme2` | `kbc-intro_*.mp3` | taking the hot seat (one of the two, at random) |
| `question`  | `kbc-question-being-asked.mp3` | each new question after the first |
| `bed`       | `kbc-suspense.mp3` | loops from Q11; stops the instant you lock |
| `tick`      | `tik-tik.mp3` | under the suspense pause after locking |
| `lock`      | `kbc-answer-locked-in.mp3` | answer locked |
| `right`     | `kbc-right-answer-new.mp3` | correct answer |
| `wrong`     | `kbc-wrong-answer.mp3` | wrong answer |
| `padav`     | `itne-paise.mp3` | crossing ₹10,000 or ₹3,20,000 |
| `win`       | `7 crore KBC .mp3` | ₹7 crore |
| `quit`      | `nahi-maanenge.mp3` | quitting |
| `fifty` `poll` `expert` `flip` | `KBC question`, `are-bhai`, `phone-rakho`, `kbc-flip-the-question` | each lifeline |
| banter pool | ten voice clips | one time in four, after a correct answer |

## Running it with sound

Audio files often will not load over `file://`. Serve the folder instead:

    cd ~/Documents/KBC && python3 -m http.server 8765

then open http://localhost:8765 — click once before expecting sound, since
browsers block audio until the page has been interacted with.

## These files are not published

`sounds/*.mp3` is gitignored. The clips stay on this machine and are not pushed
to the public repo or the live site, which falls back to the synthesized cues.
