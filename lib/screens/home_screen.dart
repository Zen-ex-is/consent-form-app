import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consent Form App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Doctor',
              style: AppTypography.heading1,
            ),
            const SizedBox(height: 20),
            Text(
              'Manage your patient consent forms efficiently.',
              style: AppTypography.bodyRegular,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Add Patient',
                    Icons.person_add,
                    () {
                      // TODO: Navigate to Add Patient
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    'Find Patient',
                    Icons.search,
                    () {
                      // TODO: Navigate to Find Patient
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    'Consent Forms',
                    Icons.description,
                    () {
                      // TODO: Navigate to Consent Forms
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    'Settings',
                    Icons.settings,
                    () {
                      // TODO: Navigate to Settings
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTypography.bodyRegularSemibold,
            ),
          ],
        ),
      ),
    );
  }
}
