String capitalize(String s) {
  return s
      .split(' ')
      .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');
}