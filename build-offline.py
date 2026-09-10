#!/usr/bin/env python3
"""Build kbc-offline.html: the game with every sound embedded, so it runs from a
double-click with no folder, no server and no network. Output is gitignored."""
import base64, hashlib, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
src  = open(os.path.join(HERE, 'index.html')).read()

referenced = set(re.findall(r"'([^']+\.mp3)'", src))
sounds = os.path.join(HERE, 'sounds')
embed, seen, missing, total = {}, {}, [], 0

for name in sorted(referenced):
    path = os.path.join(sounds, name)
    if not os.path.exists(path):
        missing.append(name); continue
    raw = open(path, 'rb').read()
    digest = hashlib.md5(raw).hexdigest()
    if digest not in seen:                       # identical clips share one payload
        seen[digest] = 'data:audio/mpeg;base64,' + base64.b64encode(raw).decode()
        total += len(raw)
    embed[name] = seen[digest]

payload = 'const EMBED={' + ','.join('%s:"%s"' % (repr(k), v) for k, v in embed.items()) + '};'
out = src.replace('const EMBED={};', payload, 1)
dest = os.path.join(HERE, 'kbc-offline.html')
open(dest, 'w').write(out)

print('embedded %d clips (%d unique payloads, %.1f MB of audio)' % (len(embed), len(seen), total/1e6))
if missing:
    print('not found, will fall back to the synth cue:', ', '.join(missing))
print('wrote %s (%.1f MB)' % (dest, os.path.getsize(dest)/1e6))
