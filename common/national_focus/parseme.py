import re

# returns (int,endpos)
def strtod(s, pos):
  m = re.match(r'[+-]?\d*[.]?\d*(?:[eE][+-]?\d+)?', s[pos:])
  if m.group(0) == '': raise ValueError('bad int: %s' % s[pos:])
  return int(m.group(0))

file1 = open("TAI_focus.txt", "r")

while True:
  line = file1.readline()
  if not line:
    break
  if line.__contains__("cost ="):
    print(strtod(line.strip(),5))