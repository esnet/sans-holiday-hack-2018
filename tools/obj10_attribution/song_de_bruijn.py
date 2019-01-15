#!/usr/bin/env python

notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
tune = ['E', 'D#', 'E', 'D#', 'E', 'E', 'D#', 'E', 'F#', 'G#', 'F#', 'G#', 'A', 'B', 'A#', 'B', 'A#', 'B']

def adjust(offset):
    result = []
    for note in tune:
        index = notes.index(note)
        index += offset
        if index >= len(notes):
            index = index % len(notes)

        result.append(notes[index])
    return result

first = tune[0]
result = adjust(0)
last = result[-1]

offsets = [0]

sequence = result[:-5]

while True:
    offset = notes.index(last) - notes.index(first)
    if offset in offsets:
        # Loop detected
        break

    result = adjust(offset)
    print "Key is now", result[0]
    last = result[-1]

    offsets.append(offset)
    sequence += result[:-5]

print "de Bruijn sequence is", len(sequence), "notes long."
print "Without de Bruijn, it would've been", len(offsets)*len(tune), "notes long."
print " ".join(sequence)
