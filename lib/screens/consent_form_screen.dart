import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../data/clinic_repository.dart';
import '../data/form_repository.dart';
import '../models/clinic.dart';
import '../models/patient.dart';
import '../models/signed_form.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/app_button.dart';
import '../widgets/consent_section.dart';
import '../utils/translations.dart';

import 'home_screen.dart';

class ConsentFormScreen extends StatefulWidget {
  final String formTitle;
  final Patient? patient;
  final Uint8List? signatureData;
  final bool isViewOnly;

  const ConsentFormScreen({
    super.key,
    required this.formTitle,
    this.patient,
    this.signatureData,
    this.isViewOnly = false,
  });

  @override
  State<ConsentFormScreen> createState() => _ConsentFormScreenState();
}

class _ConsentFormScreenState extends State<ConsentFormScreen> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  bool _isLargeFont = false;
  bool _hasSigned = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _signatureController.addListener(() {
      final hasSigned = _signatureController.isNotEmpty;
      if (_hasSigned != hasSigned) {
        setState(() {
          _hasSigned = hasSigned;
        });
      }
    });
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double textScale = _isLargeFont ? 1.2 : 1.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              widget.formTitle,
              style: AppTypography.heading3.copyWith(color: AppColors.black),
            ),
            Text(
              'Consent Form',
              style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: Column(
          children: [
            // Top Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: ['English', 'Hindi', 'Bengali', 'Gujarati']
                          .map((lang) => DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedLanguage = value);
                        }
                      },
                    ),
                  ),
                  // Font Size Toggle
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        _buildFontToggle(false),
                        Container(
                          width: 1,
                          height: 24,
                          color: AppColors.gray300,
                        ),
                        _buildFontToggle(true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.formTitle,
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Doctor Details
                    _buildDoctorDetails(),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),

                    // Consent Sections
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'nature_title'),
                      content: Translations.get(_selectedLanguage, 'nature_content'),
                    ),
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'risks_title'),
                      content: Translations.get(_selectedLanguage, 'risks_content'),
                    ),
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'contraindications_title'),
                      content: Translations.get(_selectedLanguage, 'contraindications_content'),
                    ),
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'post_treatment_title'),
                      content: Translations.get(_selectedLanguage, 'post_treatment_content'),
                    ),
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'alternatives_title'),
                      content: Translations.get(_selectedLanguage, 'alternatives_content'),
                    ),
                    ConsentSection(
                      title: Translations.get(_selectedLanguage, 'acknowledgment_title'),
                      content: Translations.get(_selectedLanguage, 'acknowledgment_content'),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Signature Section
                    Text(
                      Translations.get(_selectedLanguage, 'signature_label'),
                      style: AppTypography.heading3,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: widget.signatureData != null
                          ? null
                          : BoxDecoration(
                              color: const Color(0xFFF0F4FF), // Light blue background
                              border: Border.all(
                                color: AppColors.blue500,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                      child: widget.signatureData != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Image.memory(
                                widget.signatureData!,
                                fit: BoxFit.contain,
                              ),
                            )
                          : widget.isViewOnly
                              ? Center(
                                  child: Text(
                                    Translations.get(_selectedLanguage, 'no_signature'),
                                    style: const TextStyle(color: AppColors.gray400),
                                  ),
                                )
                              : Stack(
                              children: [
                                // Placeholder text
                                if (!_hasSigned)
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.draw_outlined,
                                            color: AppColors.gray400, size: 32),
                                        const SizedBox(height: 8),
                                        Text(
                                          Translations.get(_selectedLanguage, 'sign_here'),
                                          style: const TextStyle(color: AppColors.gray400),
                                        ),
                                      ],
                                    ),
                                  ),
                                // Signature Pad
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Signature(
                                    controller: _signatureController,
                                    backgroundColor: Colors.transparent,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                // Clear button
                                if (_hasSigned)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: const Icon(Icons.clear,
                                          color: AppColors.gray600),
                                      onPressed: () {
                                        _signatureController.clear();
                                        setState(() {
                                          _hasSigned = false;
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Patient Details
                    if (widget.patient != null) _buildPatientDetails(),
                    
                    const SizedBox(height: 40),
                    
                    // Action Buttons
                    if (!widget.isViewOnly)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: Translations.get(_selectedLanguage, 'disagree'),
                            type: AppButtonType.outline,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 16),
                          AppButton(
                            text: Translations.get(_selectedLanguage, 'agree'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            onPressed: _hasSigned
                                ? () async {
                                    // Capture signature
                                    final signatureData =
                                        await _signatureController.toPngBytes();

                                    if (signatureData != null &&
                                        widget.patient != null) {
                                      // Create SignedForm
                                      final signedForm = SignedForm(
                                        id: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        patientName: widget.patient!.name,
                                        gender: widget.patient!.gender,
                                        age: widget.patient!.age,
                                        procedureName: widget.formTitle,
                                        timestamp: DateTime.now(),
                                        signatureData: signatureData,
                                      );

                                      // Save to repository
                                      FormRepository()
                                          .addSignedForm(signedForm);
                                    }

                                    if (!context.mounted) return;

                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Consent form signed successfully'),
                                        backgroundColor: AppColors.blue500,
                                      ),
                                    );

                                    // Navigate to Signed Forms tab
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(initialIndex: 1),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontToggle(bool isLarge) {
    final isSelected = _isLargeFont == isLarge;
    return InkWell(
      onTap: () => setState(() => _isLargeFont = isLarge),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'A',
          style: TextStyle(
            fontSize: isLarge ? 20 : 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.black : AppColors.gray600,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorDetails() {
    return ValueListenableBuilder<Clinic>(
      valueListenable: ClinicRepository().clinicNotifier,
      builder: (context, clinic, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blue100),
                image: clinic.logoPath != null
                    ? DecorationImage(
                        image: FileImage(File(clinic.logoPath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: clinic.logoPath == null
                  ? const Icon(Icons.medical_services_outlined,
                      color: AppColors.blue700, size: 30)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DOCTOR',
                    style: AppTypography.bodyMicro
                        .copyWith(color: AppColors.gray600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    clinic.doctorName,
                    style: AppTypography.heading3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${clinic.addressLine1},\n${clinic.addressLine2}, ${clinic.city}, ${clinic.state} ${clinic.zipCode}",
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.gray600),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPatientDetails() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailItem('PATIENT NAME', widget.patient!.name),
            ),
            Expanded(
              child: _buildDetailItem('DATE OF BIRTH', '12 Sept 1987'), // Placeholder as per design
            ),
            Expanded(
              child: _buildDetailItem('CONTACT NUMBER', widget.patient!.phoneNumber),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildDetailItem('SEX', widget.patient!.gender),
            ),
            Expanded(
              flex: 2,
              child: _buildDetailItem('ADDRESS', 'New Vaddem, Vasco, Goa'), // Placeholder as per design
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyMicro.copyWith(color: AppColors.gray600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.bodyRegular.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
