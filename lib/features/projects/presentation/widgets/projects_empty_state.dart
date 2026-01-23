import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';

class ProjectsEmptyState extends StatelessWidget {
  const ProjectsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              // In production use an SVG or Image asset as per design
              // color: AppColors.surfaceAlt,
              // shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.folder_open_rounded,
                  size: 100,
                  color: AppColors.primary.withOpacity(
                    0.2,
                  ), // Light blue folder
                ),
                Positioned(
                  right: 50,
                  bottom: 60,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: AppElevation.card,
                    ),
                    child: const Icon(
                      Icons.push_pin_rounded,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  bottom: 50,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: AppElevation.card,
                    ),
                    child: const Icon(
                      Icons.code_rounded,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppText.title(
            'Ready to launch something new?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(
            width: 400,
            child: AppText.body(
              'Your project list is currently empty. Start tracking your IT workflows and operational tasks by creating your first entry.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.read<ProjectsBloc>().add(const CreateProject());
                },
                icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                label: const Text('Create first project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              OutlinedButton(
                onPressed: () {
                  // Clear filters action - creates dummy for now?
                  // Design says "Clear all filters" but logic implies creating items?
                  // Just leaving concise for dummy
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: const Text('Clear all filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
