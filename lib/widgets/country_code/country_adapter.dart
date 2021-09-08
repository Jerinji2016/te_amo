
import 'package:flutter/material.dart';
import 'package:te_amo/widgets/country_code/country.dart';

import 'country_codes.dart';

class CountryAdapter {
  List<Country> values = [];
  late Country country;

  CountryAdapter(BuildContext context) {
    //  load all countries data
    values = List.from(
      codes.map((map) => Country(map["name"]!, map["code"]!, map["dial_code"]?.replaceAll(" ", "") ?? "null")).toList(),
    );

    country = values.firstWhere((element) => element.dialCode == "+91");
  }
}
