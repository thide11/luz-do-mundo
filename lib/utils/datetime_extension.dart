extension DateTimeEx on DateTime {
  toBrazilianDateString() {
    return "${_formatDateNumber(this.day)}/${_formatDateNumber(this.month)}/${this.year}";
  }

  _formatDateNumber(int number) {
    if(number < 10) {
      return "0$number";
    }
    return number;
  }
}