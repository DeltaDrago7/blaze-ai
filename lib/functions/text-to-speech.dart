
int getWordEndIndex(String sentence, int startIndex) {
  if (startIndex >= sentence.length) return sentence.length;

  // Skip any leading whitespace
  while (startIndex < sentence.length && sentence[startIndex].trim().isEmpty) {
    startIndex++;
  }

  int i = startIndex;
  while (i < sentence.length && sentence[i].trim().isNotEmpty && !isPunctuation(sentence[i])) {
    i++;
  }

  return i; // exclusive end index
}

bool isPunctuation(String char) {
  const punctuation = {'.', ',', '?', '!', ';', ':', '(', ')', '[', ']', '{', '}', '"', '\''};
  return punctuation.contains(char);
}
