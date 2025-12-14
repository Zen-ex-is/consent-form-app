import '../models/signed_form.dart';

class FormRepository {
  static final FormRepository _instance = FormRepository._internal();
  
  factory FormRepository() {
    return _instance;
  }
  
  FormRepository._internal();
  
  final List<SignedForm> _signedForms = [];
  
  List<SignedForm> get signedForms => List.unmodifiable(_signedForms);
  
  void addSignedForm(SignedForm form) {
    _signedForms.insert(0, form); // Add to top
  }
}
