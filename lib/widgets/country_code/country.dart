class Country {
  final String name;
  final String code;
  final String dialCode;

  Country(this.name, this.code, this.dialCode);

  static Country none(String num) => Country("Invalid country code", "null", num);
}
