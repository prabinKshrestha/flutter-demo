class StringHelper {}

extension StringExtensions on String {
  String splitAtRegularLength(int count, String character) {
    return this.splitMapJoin(RegExp('.{1,4}'), onMatch: (Match match) => '${match.input.substring(match.start, match.end)}$character');
  }

  String capitalize() => this.split(" ").map((str) => "${str[0].toUpperCase()}${str.substring(1)}").join(" ");
}
