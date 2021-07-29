class EnumDto {
  static String getValue(value) {
    String valor = value.toString();
    int index = valor.indexOf('.') + 1;
    return valor.substring(index);
  }

  static findValue(List<dynamic> possibleValues, String searchValue) {
    List<String> enumString = possibleValues.map(getValue).toList();
    String value = enumString.firstWhere((e) => e == searchValue,
        orElse: () => throw Error()
    );
    final result =
        possibleValues.firstWhere((e) => e.toString() == "Status.$value");
    return result;
  }
}