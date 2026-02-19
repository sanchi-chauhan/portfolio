import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  static const String _profileImagePath = 'assets/profile.jpg';
  final AutoScrollController scrollController;

  const AboutSection({
    super.key,
    required this.scrollController,
  });

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _downloadResume() async {
    // Open Google Drive direct file link to view resume
    final resumeUrl =
        'https://drive.google.com/file/d/107OIcfYsl4Tdok82DR2ST-GGqXTAv4h2/view?usp=sharing';
    try {
      final uri = Uri.parse(resumeUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      print('Error opening resume: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width > 1200
                ? 1200
                : double.infinity,
            child: MediaQuery.of(context).size.width > 800
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side - Image and Experience (30%)
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Profile Image - Circular
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2),
                                    Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.2),
                                  ],
                                ),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2),
                                    blurRadius: 30,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipOval(
                                  child: Image.asset(
                                    _profileImagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 400.ms)
                                .slideX(begin: -0.3, end: 0),
                            const SizedBox(height: 32),
                            // Experience Card - Bigger and Wider
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'GeekyAnts Pvt. Ltd.',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '2 yr 3 months',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Bengaluru, Karnataka, India',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      _ExperienceItem(
                                        title: 'Software Engineer 3',
                                        period:
                                            'Full time • July 2025 - Present',
                                      ),
                                      const SizedBox(height: 16),
                                      _ExperienceItem(
                                        title: 'Software Engineer 2',
                                        period: 'July 2024 - 25',
                                      ),
                                      const SizedBox(height: 16),
                                      _ExperienceItem(
                                        title: 'Software Engineer 1',
                                        period: 'May 2022 - 24',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 600.ms)
                                .slideY(begin: 0.3, end: 0),
                          ],
                        ),
                      ),
                      const SizedBox(width: 60),
                      // Right Side - Description and Skills (70%)
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // About Me Title
                            Text(
                              'About Me',
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
                            const SizedBox(height: 32),
                            Text(
                              'I am a software engineer enthusiastic and inspired by technology.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                height: 1.8,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 400.ms)
                                .slideY(begin: -0.3, end: 0),
                            const SizedBox(height: 24),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  height: 1.8,
                                ),
                                children: [
                                  const TextSpan(text: 'Currently working at '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _launchURL('https://geekyants.com/'),
                                      child: Text(
                                        'GeekyAnts',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          height: 1.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                      text: ' as Software Engineer 3.'),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 600.ms)
                                .slideY(begin: -0.3, end: 0),
                            const SizedBox(height: 24),
                            Text(
                              'I had the opportunity to work with a German client on a dating application, where I single-handedly handled and fixed the entire project, managing everything from development to deployment.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                height: 1.8,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 800.ms)
                                .slideY(begin: 0.3, end: 0),
                            const SizedBox(height: 24),
                            Text(
                              'Following that, I worked on a comprehensive healthcare application, delivering innovative features and solutions that significantly improved user experience and functionality.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                height: 1.8,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 1000.ms)
                                .slideY(begin: 0.3, end: 0),
                            const SizedBox(height: 32),
                            // Download Resume Button
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _downloadResume();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                icon: const Icon(Icons.download, size: 20),
                                label: const Text(
                                  'Download Resume',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 1200.ms)
                                .scale(delay: 1200.ms),
                            const SizedBox(height: 32),
                            // Skills Section
                            Text(
                              'Skills',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.color,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 1400.ms)
                                .slideX(begin: -0.3, end: 0),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _SkillChip(label: 'Flutter', delay: 1500),
                                _SkillChip(label: 'Bloc', delay: 1550),
                                _SkillChip(label: 'Dart', delay: 1600),
                                _SkillChip(label: 'GraphQL', delay: 1650),
                                _SkillChip(
                                    label: 'API Integration', delay: 1700),
                                _SkillChip(label: 'CI/CD', delay: 1750),
                                _SkillChip(label: 'Firebase', delay: 1800),
                                _SkillChip(label: 'Git', delay: 1850),
                                _SkillChip(label: 'MVVM', delay: 1900),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    // Mobile/Tablet Layout
                    children: [
                      // Profile Image - Circular (Mobile)
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.2),
                            ],
                          ),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                            child: Image.asset(
                              _profileImagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 400.ms)
                          .scale(delay: 400.ms),
                      const SizedBox(height: 32),
                      // About Me Title (Mobile)
                      Text(
                        'About Me',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 28
                                  : 36,
                            ),
                        textAlign: TextAlign.center,
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
                      const SizedBox(height: 32),
                      // Experience Card (Mobile)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'GeekyAnts Pvt. Ltd.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '2 yr 3 months',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Bengaluru, Karnataka, India',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _ExperienceItem(
                              title: 'Software Engineer 3',
                              period: 'Full time • July 2025 - Present',
                            ),
                            const SizedBox(height: 14),
                            _ExperienceItem(
                              title: 'Software Engineer 2',
                              period: 'July 2024 - 25',
                            ),
                            const SizedBox(height: 14),
                            _ExperienceItem(
                              title: 'Software Engineer 1',
                              period: 'May 2022 - 24',
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 600.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 32),
                      // Description (Mobile)
                      Text(
                        'I am a software engineer enthusiastic and inspired by technology.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.8,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 400.ms)
                          .slideY(begin: -0.3, end: 0),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            height: 1.8,
                          ),
                          children: [
                            const TextSpan(text: 'Currently working at '),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () =>
                                    _launchURL('https://geekyants.com/'),
                                child: Text(
                                  'GeekyAnts',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' as Software Engineer 3.'),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 600.ms)
                          .slideY(begin: -0.3, end: 0),
                      const SizedBox(height: 20),
                      Text(
                        'I had the opportunity to work with a German client on a dating application, where I single-handedly handled and fixed the entire project, managing everything from development to deployment.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.8,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 800.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 20),
                      Text(
                        'Following that, I worked on a comprehensive healthcare application, delivering innovative features and solutions that significantly improved user experience and functionality.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.8,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1000.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 32),
                      // Download Resume Button (Mobile)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _downloadResume();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.download, size: 20),
                          label: const Text(
                            'Download Resume',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1200.ms)
                          .scale(delay: 1200.ms),
                      const SizedBox(height: 32),
                      // Skills Section (Mobile)
                      Text(
                        'Skills',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).textTheme.headlineMedium?.color,
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1400.ms)
                          .slideX(begin: -0.3, end: 0),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          _SkillChip(label: 'Flutter', delay: 1500),
                          _SkillChip(label: 'Bloc', delay: 1550),
                          _SkillChip(label: 'Dart', delay: 1600),
                          _SkillChip(label: 'GraphQL', delay: 1650),
                          _SkillChip(label: 'API Integration', delay: 1700),
                          _SkillChip(label: 'CI/CD', delay: 1750),
                          _SkillChip(label: 'Firebase', delay: 1800),
                          _SkillChip(label: 'Git', delay: 1850),
                          _SkillChip(label: 'MVVM', delay: 1900),
                        ],
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
  final String period;

  const _ExperienceItem({
    required this.title,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          period,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final int delay;

  const _SkillChip({
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: delay.ms)
        .scale(delay: delay.ms);
  }
}
