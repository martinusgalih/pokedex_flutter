extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String capitalizeEachWord() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty ? word.capitalize() : '')
        .join(' ');
  }
}
