class Patient {
  final String name;
  final String gender;
  final int age;
  final String phoneNumber;

  Patient({
    required this.name,
    required this.gender,
    required this.age,
    required this.phoneNumber,
  });

  String get initials {
    List<String> names = name.split(" ");
    String initials = "";
    if (names.isNotEmpty) {
      initials += names[0][0];
      if (names.length > 1) {
        initials += names[names.length - 1][0];
      }
    }
    return initials.toUpperCase();
  }
}
