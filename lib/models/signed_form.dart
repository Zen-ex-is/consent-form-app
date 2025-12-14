import 'dart:typed_data';

class SignedForm {
  final String id;
  final String patientName;
  final String gender;
  final int age;
  final String procedureName;
  final DateTime timestamp;
  final Uint8List? signatureData;

  SignedForm({
    required this.id,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.procedureName,
    required this.timestamp,
    this.signatureData,
  });
}
