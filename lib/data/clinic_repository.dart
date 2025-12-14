import 'package:flutter/foundation.dart';
import '../models/clinic.dart';

class ClinicRepository {
  static final ClinicRepository _instance = ClinicRepository._internal();

  factory ClinicRepository() {
    return _instance;
  }

  ClinicRepository._internal();

  final ValueNotifier<Clinic> clinicNotifier = ValueNotifier<Clinic>(
    Clinic(
      doctorFirstName: 'Praveen',
      doctorSurname: 'Varghese',
      phoneNumber: '+91 9876543210',
      addressLine1: "Dr Praveen's Dental Clinic",
      addressLine2: 'Radha, B4, New Vaddem',
      city: 'Vasco Da Gama',
      state: 'Goa',
      zipCode: '403802',
    ),
  );

  Clinic get currentClinic => clinicNotifier.value;

  void updateClinic(Clinic clinic) {
    clinicNotifier.value = clinic;
  }
}
