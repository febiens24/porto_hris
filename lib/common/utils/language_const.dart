class Languages {
  const Languages._();

  static const languages = [
    LanguageEntity(code: 'en', value: 'English', flag: "🇺🇸"),
    LanguageEntity(code: 'id', value: 'Indonesia', flag: "🇮🇩"),
  ];
}

class LanguageEntity {
  final String code;
  final String value;
  final String flag;

  const LanguageEntity(
      {required this.code, required this.value, required this.flag});
}
