import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/clinic_repository.dart';
import '../models/clinic.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ClinicDetailsScreen extends StatefulWidget {
  const ClinicDetailsScreen({super.key});

  @override
  State<ClinicDetailsScreen> createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _surnameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressLine1Controller;
  late TextEditingController _addressLine2Controller;
  late TextEditingController _zipCodeController;
  late TextEditingController _pinController;
  late TextEditingController _repeatPinController;

  String _selectedCountryCode = '+91';
  String? _selectedCity;
  String? _selectedState;
  String? _logoPath;

  final List<String> _cities = ['Vasco Da Gama', 'Panaji', 'Margao', 'Mapusa'];
  final List<String> _states = ['Goa', 'Maharashtra', 'Karnataka'];

  @override
  void initState() {
    super.initState();
    final clinic = ClinicRepository().currentClinic;
    _firstNameController = TextEditingController(text: clinic.doctorFirstName);
    _surnameController = TextEditingController(text: clinic.doctorSurname);
    _phoneController = TextEditingController(text: clinic.phoneNumber.replaceAll('+91 ', ''));
    _addressLine1Controller = TextEditingController(text: clinic.addressLine1);
    _addressLine2Controller = TextEditingController(text: clinic.addressLine2);
    _zipCodeController = TextEditingController(text: clinic.zipCode);
    _pinController = TextEditingController(text: clinic.pin);
    _repeatPinController = TextEditingController(text: clinic.pin);
    _logoPath = clinic.logoPath;
    _selectedCity = _cities.contains(clinic.city) ? clinic.city : null;
    _selectedState = _states.contains(clinic.state) ? clinic.state : null;
    
    // If city/state from repo aren't in list, maybe add them or just leave null/text input.
    // For now, I'll just ensure they are valid or null.
    if (_selectedCity == null && clinic.city.isNotEmpty) {
       // If the current city is not in the list, we might want to handle it. 
       // But for this mock, I'll just default to null or the first one if I must.
       // Or better, I'll add it to the list dynamically? No, let's keep it simple.
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _zipCodeController.dispose();
    _pinController.dispose();
    _repeatPinController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        setState(() {
          _logoPath = image.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _saveClinicDetails() {
    if (_formKey.currentState!.validate()) {
      if (_pinController.text != _repeatPinController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PINs do not match')),
        );
        return;
      }

      final updatedClinic = Clinic(
        doctorFirstName: _firstNameController.text,
        doctorSurname: _surnameController.text,
        phoneNumber: '$_selectedCountryCode ${_phoneController.text}',
        addressLine1: _addressLine1Controller.text,
        addressLine2: _addressLine2Controller.text,
        city: _selectedCity ?? '',
        state: _selectedState ?? '',
        zipCode: _zipCodeController.text,
        logoPath: _logoPath,
        pin: _pinController.text,
      );

      ClinicRepository().updateClinic(updatedClinic);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Clinic details',
          style: AppTypography.heading3.copyWith(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.gray200,
                      shape: BoxShape.circle,
                      image: _logoPath != null
                          ? DecorationImage(
                              image: FileImage(File(_logoPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _logoPath == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add Image',
                                style: AppTypography.bodySmallSemibold
                                    .copyWith(color: AppColors.gray600),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Doctor Information
              Text('Doctor Information', style: AppTypography.bodySmallSemibold),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _firstNameController,
                hintText: 'First name',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _surnameController,
                hintText: 'Surname',
              ),
              const SizedBox(height: 24),

              // Contact Number
              Text('Contact Number', style: AppTypography.bodySmallSemibold),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCountryCode,
                        isExpanded: true,
                        items: ['+91', '+1', '+44']
                            .map((code) => DropdownMenuItem(
                                  value: code,
                                  child: Text(code),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedCountryCode = value);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _phoneController,
                      hintText: 'Phone number', // Changed from "Address line 2" as per logic
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Clinic Address
              Text('Clinic Address', style: AppTypography.bodySmallSemibold),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _addressLine1Controller,
                hintText: 'Address line 1',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _addressLine2Controller,
                hintText: 'Address line 2',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      value: _selectedCity,
                      hint: 'City',
                      items: _cities,
                      onChanged: (val) => setState(() => _selectedCity = val),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdown(
                      value: _selectedState,
                      hint: 'State',
                      items: _states,
                      onChanged: (val) => setState(() => _selectedState = val),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _zipCodeController,
                      hintText: 'Zip code',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Set PIN
              Text('Set PIN', style: AppTypography.bodySmallSemibold),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _pinController,
                      hintText: 'Enter PIN',
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _repeatPinController,
                      hintText: 'Repeat PIN',
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: const BorderSide(color: AppColors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.black),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveClinicDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue500,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.gray400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blue500),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Optional validation, maybe some fields are optional
          if (hintText.contains('Address line 2')) return null;
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: AppTypography.bodySmall.copyWith(color: AppColors.gray400)),
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
