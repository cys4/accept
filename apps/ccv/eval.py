def load():
  out = []
  with open('my_output.txt') as f:
    for line in f:
      first_num = line
      out.append(float(first_num))
  return out

def score(orig, relaxed):
  total = 0.0
  for a, b in zip(orig, relaxed):
    total += min(abs(a - b), 1.0)
  return total / len(orig)
