import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/form_card.dart';

import 'add_patient_screen.dart';
import 'signed_forms_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.black),
            onPressed: () {},
          ),
          title: Center(
            child: Text(
              'Dr. Pravin\'s Clinic',
              style: AppTypography.heading3.copyWith(color: AppColors.black),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline, color: AppColors.black),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.gray200, width: 1),
                ),
              ),
              child: const TabBar(
                labelColor: AppColors.blue500,
                unselectedLabelColor: AppColors.gray500,
                indicatorColor: AppColors.blue500,
                indicatorWeight: 3,
                labelStyle: AppTypography.bodySmallSemibold,
                tabs: [
                  Tab(text: 'Consent Forms'),
                  Tab(text: 'Signed Forms'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildConsentFormsTab(context),
            const SignedFormsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppColors.blue500,
          icon: const Icon(Icons.edit, color: AppColors.white),
          label: const Text(
            'Add',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildConsentFormsTab(BuildContext context) {
    final List<Map<String, dynamic>> forms = [
      {'title': 'Crown and Bridge Procedures', 'icon': Icons.medical_services_outlined},
      {'title': 'Dental Implant Procedure', 'icon': Icons.hardware_outlined},
      {'title': 'Teeth whitening Treatment', 'icon': Icons.clean_hands_outlined},
      {'title': 'Dental Radiographs', 'icon': Icons.image_outlined},
      {'title': 'Dental Examination', 'icon': Icons.search_outlined},
      {'title': 'Local Anaesthesia', 'icon': Icons.colorize_outlined},
      {'title': 'Root Canal Treatment', 'icon': Icons.healing_outlined},
      {'title': 'Orthodontic Treatment', 'icon': Icons.sentiment_very_satisfied_outlined},
      {'title': 'Removable Prosthodontics Treatment', 'icon': Icons.build_outlined},
      {'title': 'Root Canal Treatment', 'icon': Icons.healing_outlined},
      {'title': 'Scaling and Root Planing', 'icon': Icons.cleaning_services_outlined},
      {'title': 'Tooth Removal / Minor Oral Surgery', 'icon': Icons.delete_outline},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            itemCount: forms.length,
            itemBuilder: (context, index) {
              return FormCard(
                title: forms[index]['title'],
                icon: forms[index]['icon'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPatientScreen(
                        formTitle: forms[index]['title'],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Other forms',
            style: AppTypography.heading3.copyWith(color: AppColors.gray600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: GridView.count(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               crossAxisCount: 2,
               crossAxisSpacing: 16,
               mainAxisSpacing: 16,
               childAspectRatio: 2.5,
               children: [
                 FormCard(
                   title: 'Patient Case History',
                   icon: Icons.person_outline,
                   onTap: () {},
                 ),
               ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
