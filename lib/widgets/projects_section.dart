import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  // Live Demo URL - deployed chat application
  static const String chatAppDemoUrl =
      'https://chat-application-3hhy.onrender.com';
  final AutoScrollController scrollController;

  const ProjectsSection({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Tech AI Assistant',
        'description':
            'An intelligent chat application with real-time messaging that specializes in answering technology and computer science questions using Socket.io and AI-powered responses.',
        'tech': ['Node.js', 'Express', 'Socket.io', 'MongoDB', 'EJS'],
        'color': Theme.of(context).colorScheme.primary,
        'codeLink': 'https://github.com/sanchi-chauhan/chat-application#',
        'demoLink': chatAppDemoUrl,
      },
      {
        'title': 'NowMatch - Dating & Social App',
        'description':
            'A next-generation cross-platform dating and social discovery app built with Flutter, Hasura, and Firebase. Features include swipe-based matching, real-time "Hey Ads" for activity partners, BLoC state management, GraphQL subscriptions, and seamless multi-platform deployment with 100% feature parity.',
        'tech': ['Flutter', 'Dart', 'GraphQL', 'Hasura', 'Firebase', 'BLoC'],
        'color': Theme.of(context).colorScheme.tertiary,
        'caseStudyLink':
            'https://geekyants.com/case-studies/nowmatch-next-gen-dating-and-social-app',
      },
      {
        'title': 'Tic Tac Toe',
        'description':
            'A classic Tic Tac Toe game with an intuitive interface, win detection, and smooth gameplay. Features include player vs player mode, game reset functionality, and visual feedback for moves.',
        'tech': ['Flutter', 'Dart', 'Game Development'],
        'color': Theme.of(context).colorScheme.secondary,
        'codeLink': 'https://github.com/sanchi-chauhan/tic-tac-toe',
        'demoLink': 'https://sanchi-chauhan.github.io/tic-tac-toe/',
      },
      {
        'title': 'Daily Planner',
        'description':
            'A beautiful and modern daily planner application that helps you organize your day by adding and managing tasks. Features include time-based task scheduling, color-coded tasks, persistent storage, and navigation between yesterday, today, and tomorrow. Built with a user-friendly interface designed for productivity.',
        'tech': ['Flutter', 'Dart', 'SharedPreferences', 'Local Storage'],
        'color': Theme.of(context).colorScheme.primary,
        'codeLink': 'https://github.com/sanchi-chauhan/daily_planner/',
        'demoLink': 'https://sanchi-chauhan.github.io/daily_planner/',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width > 600 ? 20 : 26,
        horizontal: 48,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.displaySmall,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
          const SizedBox(height: 10),
          Container(
            width: 45,
            height: 2,
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
          const SizedBox(height: 10),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: _ProjectCard(
                      title: project['title'] as String,
                      description: project['description'] as String,
                      tech: project['tech'] as List<String>,
                      color: project['color'] as Color,
                      delay: 400 + (index * 200),
                      codeLink: project['codeLink'] as String?,
                      demoLink: project['demoLink'] as String?,
                      caseStudyLink: project['caseStudyLink'] as String?,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tech;
  final Color color;
  final int delay;
  final String? codeLink;
  final String? demoLink;
  final String? caseStudyLink;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tech,
    required this.color,
    required this.delay,
    this.codeLink,
    this.demoLink,
    this.caseStudyLink,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  bool _isTextOverflowing({
    required String text,
    required TextStyle style,
    required double maxWidth,
    required int maxLines,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -10.0 : 0.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? widget.color : widget.color.withOpacity(0.3),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_isHovered ? 0.3 : 0.2),
                blurRadius: _isHovered ? 40 : 30,
                offset: Offset(0, _isHovered ? 25 : 20),
              ),
            ],
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmallScreen = constraints.maxWidth < 400;
                    final buttonDecoration = BoxDecoration(
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
                    );
                    return Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 5 : 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: isSmallScreen ? 2 : 3),
                          Flexible(
                            child: Builder(
                              builder: (context) {
                                final descriptionStyle = TextStyle(
                                  fontSize: isSmallScreen ? 10 : 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  height: 1.3,
                                );
                                final horizontalPadding =
                                    (isSmallScreen ? 5.0 : 22.0) * 2;
                                final availableWidth =
                                    (constraints.maxWidth - horizontalPadding) >
                                            0
                                        ? (constraints.maxWidth -
                                            horizontalPadding)
                                        : constraints.maxWidth;
                                final isOverflowing = _isTextOverflowing(
                                  text: widget.description,
                                  style: descriptionStyle,
                                  maxWidth: availableWidth,
                                  maxLines: 3,
                                );

                                final descriptionText = Text(
                                  widget.description,
                                  style: descriptionStyle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                );

                                if (!isOverflowing) {
                                  return descriptionText;
                                }

                                return Tooltip(
                                  message: widget.description,
                                  waitDuration:
                                      const Duration(milliseconds: 200),
                                  preferBelow: true,
                                  constraints: BoxConstraints(
                                    maxWidth: isSmallScreen ? 220 : 280,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: widget.color.withOpacity(0.35),
                                      width: 1,
                                    ),
                                  ),
                                  textStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontSize: isSmallScreen ? 11 : 13,
                                    height: 1.35,
                                  ),
                                  child: descriptionText,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 3 : 10),
                          Wrap(
                            spacing: isSmallScreen ? 2 : 2,
                            runSpacing: isSmallScreen ? 2 : 2,
                            children: widget.tech.take(2).map((t) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 3 : 8,
                                  vertical: isSmallScreen ? 1 : 6,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: widget.color.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 6 : 15,
                                    color: widget.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const Spacer(),
                          // Show case study link button if available, otherwise show code/demo buttons
                          if (widget.caseStudyLink != null)
                            Container(
                              decoration: buttonDecoration,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    final uri =
                                        Uri.parse(widget.caseStudyLink!);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  } catch (e) {
                                    print('Error launching case study URL: $e');
                                  }
                                },
                                icon: Icon(Icons.article,
                                    size: isSmallScreen ? 14 : 18),
                                label: Text(
                                    isSmallScreen
                                        ? 'Case Study'
                                        : 'View Case Study',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 12 : 15)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 12 : 16,
                                      vertical: isSmallScreen ? 16 : 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: buttonDecoration,
                                    child: TextButton.icon(
                                    onPressed: () async {
                                      if (widget.codeLink != null) {
                                        final uri = Uri.parse(widget.codeLink!);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.code,
                                        size: isSmallScreen ? 14 : 18),
                                    label: Text(
                                        isSmallScreen ? 'Code' : 'View Code',
                                        style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 15)),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: isSmallScreen ? 16 : 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                ),
                                SizedBox(width: isSmallScreen ? 8 : 16),
                                Expanded(
                                  child: Container(
                                    decoration: buttonDecoration,
                                    child: TextButton.icon(
                                    onPressed: () async {
                                      if (widget.demoLink != null) {
                                        try {
                                          final uri =
                                              Uri.parse(widget.demoLink!);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(
                                              uri,
                                              mode: LaunchMode.platformDefault,
                                            );
                                          } else {
                                            await launchUrl(
                                              uri,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        } catch (e) {
                                          try {
                                            final uri =
                                                Uri.parse(widget.demoLink!);
                                            await launchUrl(
                                              uri,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          } catch (e2) {
                                            print('Error launching URL: $e2');
                                          }
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.open_in_new,
                                        size: isSmallScreen ? 14 : 18),
                                    label: Text(
                                        isSmallScreen ? 'Demo' : 'Live Demo',
                                        style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 15)),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: isSmallScreen ? 16 : 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms, delay: widget.delay.ms)
            .slideY(begin: 0.3, end: 0)
            .shimmer(
              delay: (widget.delay + 400).ms,
              duration: 2000.ms,
              color: widget.color.withOpacity(0.3),
            ));
  }
}
