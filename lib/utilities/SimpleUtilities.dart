class SimpleUtilities {
  /// [word] - Базовая часть слова без окончания
  /// [count] - Количество от которого будет зависеть окончание слова
  /// [singleEnding] - Одиночное окончание слова
  /// [pluralEnding1] - Множественное окончание слова вариант 1
  /// [pluralEnding2] - Множественное окончание слова вариант 2
  static String setWordEnding({
    String word,
    int count,
    String singleEnding,
    String pluralEnding1,
    String pluralEnding2,
  }) {
    assert(word != null);
    assert(count != null);
    assert(singleEnding != null);
    assert(pluralEnding1 != null);
    assert(pluralEnding2 != null);

    final m = count % 100;
    final n = m % 10;

    if (m % 100 == 11) {
      return word + pluralEnding2;
    }

    if (n == 1) {
      return word + singleEnding;
    } else if (n > 1 && n < 5) {
      return word + pluralEnding1;
    } else {
      return word + pluralEnding2;
    }
  }

  static stringURLCheck(String str) {
    assert(str != null);

    final r = RegExp(
        r'(ftp:\/\/|www\.|https?:\/\/){1}[a-zA-Z0-9u00a1-\uffff0-]{2,}\.[a-zA-Z0-9u00a1-\uffff0-]{2,}(\S*)',
        multiLine: true);

    return r.hasMatch(str);
  }

  static extractIdFromYTURL(String url) {
    final r = RegExp(
        r"^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*");

    try {
      return r.firstMatch(url).group(1);
    } catch (_) {
      return null;
    }
  }
}