class SignedForm {
  final String id;
  final String patientName;
  final String gender;
  final int age;
  final String procedureName;
  final DateTime timestamp;

  SignedForm({
    required this.id,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.procedureName,
    required this.timestamp,
  });
}
