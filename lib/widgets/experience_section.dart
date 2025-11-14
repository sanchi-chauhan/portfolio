import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExperienceSection extends StatelessWidget {
  final AutoScrollController scrollController;

  const ExperienceSection({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Text(
            'Experience',
            style: Theme.of(context).textTheme.displaySmall,
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.3, end: 0),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .scaleX(delay: 200.ms),
          const SizedBox(height: 60),
          SizedBox(
            width: MediaQuery.of(context).size.width > 800 ? 800 : double.infinity,
            child: Column(
              children: [
                _ExperienceItem(
                  title: 'Flutter Developer',
                  company: 'Your Company Name',
                  period: '2022 - Present',
                  description: 'Developed and maintained Flutter applications for iOS and Android platforms. Implemented state management solutions, integrated REST APIs, and created custom UI components.',
                  delay: 400,
                ),
                const SizedBox(height: 32),
                _ExperienceItem(
                  title: 'Junior Flutter Developer',
                  company: 'Your Previous Company',
                  period: '2022 - 2023',
                  description: 'Worked on mobile app development using Flutter. Collaborated with the team to deliver high-quality applications and learned best practices in Flutter development.',
                  delay: 600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String title;
  final String company;
  final String period;
  final String description;
  final int delay;

  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.work,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: delay.ms)
        .slideX(begin: -0.3, end: 0);
  }
}

