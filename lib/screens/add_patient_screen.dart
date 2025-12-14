import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'consent_form_screen.dart';

class AddPatientScreen extends StatefulWidget {
  final String formTitle;

  const AddPatientScreen({super.key, required this.formTitle});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Patient> _filteredPatients = [];
  
  final List<Patient> _allPatients = [
    Patient(name: 'Sanam Naik', gender: 'FEMALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Sameer Kumar', gender: 'MALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Samik Naik', gender: 'FEMALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Sanu Nigam', gender: 'MALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Samik G', gender: 'FEMALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Sangu Kumar', gender: 'MALE', age: 32, phoneNumber: '+91 96612638201'),
    Patient(name: 'Kumar Sans', gender: 'MALE', age: 32, phoneNumber: '+91 96612638201'),
  ];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients = _allPatients.where((patient) {
        return patient.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add patient',
              style: AppTypography.heading3.copyWith(color: AppColors.black),
            ),
            Text(
              widget.formTitle,
              style: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Patient',
              style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.blue500),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.blue500),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.blue500, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Suggestions',
              style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _filteredPatients.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.gray200),
                itemBuilder: (context, index) {
                  final patient = _filteredPatients[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.gray100,
                          child: Text(
                            patient.initials,
                            style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.black),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patient.name,
                                style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.black),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${patient.gender} • ${patient.age} YRS',
                                style: AppTypography.bodyMicro.copyWith(color: AppColors.gray500),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                patient.phoneNumber,
                                style: AppTypography.bodyMicro.copyWith(color: AppColors.gray500),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsentFormScreen(
                                  formTitle: widget.formTitle,
                                  patient: patient,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Add',
                                style: AppTypography.bodySmallSemibold.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 16, color: AppColors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
