class Clinic {
  final String doctorFirstName;
  final String doctorSurname;
  final String phoneNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String? logoPath;
  final String pin;

  Clinic({
    required this.doctorFirstName,
    required this.doctorSurname,
    required this.phoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    this.logoPath,
    this.pin = '',
  });

  String get doctorName => '$doctorFirstName $doctorSurname';
  String get fullAddress => [
        addressLine1,
        addressLine2,
        city,
        state,
        zipCode
      ].where((e) => e.isNotEmpty).join(', ');

  Clinic copyWith({
    String? doctorFirstName,
    String? doctorSurname,
    String? phoneNumber,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? zipCode,
    String? logoPath,
    String? pin,
  }) {
    return Clinic(
      doctorFirstName: doctorFirstName ?? this.doctorFirstName,
      doctorSurname: doctorSurname ?? this.doctorSurname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      logoPath: logoPath ?? this.logoPath,
      pin: pin ?? this.pin,
    );
  }
}
