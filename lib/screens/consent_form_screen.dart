import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/consent_section.dart';

class ConsentFormScreen extends StatelessWidget {
  final String formTitle;
  final Patient? patient;

  const ConsentFormScreen({
    super.key,
    required this.formTitle,
    this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          formTitle,
          style: AppTypography.heading3.copyWith(color: AppColors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined, color: AppColors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header / Introduction
            Text(
              'Please read the following information carefully before signing.',
              style: AppTypography.bodyRegular.copyWith(
                color: AppColors.gray500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),

            // Reusable Sections
            const ConsentSection(
              title: '1. Nature of Procedure',
              content:
                  'I hereby authorize Dr. Pravin and his team to perform the procedure(s) discussed. The nature and purpose of the procedure have been explained to me, and I understand what is involved.',
            ),
            const ConsentSection(
              title: '2. Risks and Complications',
              content:
                  'I understand that there are potential risks and complications associated with any dental procedure, including but not limited to pain, swelling, infection, bleeding, and temporary or permanent numbness. Specific risks related to this procedure have been discussed with me.',
            ),
            const ConsentSection(
              title: '3. Alternatives',
              content:
                  'I have been informed of possible alternative treatments, including no treatment at all, and the risks and benefits of each have been explained to me.',
            ),
            const ConsentSection(
              title: '4. Anesthesia',
              content:
                  'I consent to the administration of local anesthesia as deemed necessary by the doctor. I understand the risks associated with anesthesia.',
            ),
            
            const SizedBox(height: 32),
            
            // Placeholder for Signature
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray300),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.gray100.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  'Signature Pad Placeholder',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gray400),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.blue500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTypography.bodyRegularSemibold.copyWith(
                        color: AppColors.blue500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Save consent form
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue500,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Sign & Save',
                      style: AppTypography.bodyRegularSemibold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
