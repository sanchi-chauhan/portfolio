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
        'title': 'Tic Tac Toe',
        'description':
            'A classic Tic Tac Toe game with an intuitive interface, win detection, and smooth gameplay. Features include player vs player mode, game reset functionality, and visual feedback for moves.',
        'tech': ['Flutter', 'Dart', 'Game Development'],
        'color': Theme.of(context).colorScheme.tertiary,
        'codeLink': 'https://github.com/sanchi-chauhan/tic-tac-toe',
        'demoLink': 'https://sanchi-chauhan.github.io/tic-tac-toe/',
      },
      {
        'title': 'Daily Planner',
        'description':
            'A beautiful and modern daily planner application that helps you organize your day by adding and managing tasks. Features include time-based task scheduling, color-coded tasks, persistent storage, and navigation between yesterday, today, and tomorrow. Built with a user-friendly interface designed for productivity.',
        'tech': ['Flutter', 'Dart', 'SharedPreferences', 'Local Storage'],
        'color': Theme.of(context).colorScheme.secondary,
        'codeLink': 'https://github.com/sanchi-chauhan/daily_planner/',
        'demoLink': 'https://sanchi-chauhan.github.io/daily_planner/',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
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
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.displaySmall,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1000
                  ? 3
                  : MediaQuery.of(context).size.width > 600
                      ? 2
                      : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.8,
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
                ),
              );
            },
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

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tech,
    required this.color,
    required this.delay,
    this.codeLink,
    this.demoLink,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withOpacity(_isHovered ? 0.4 : 0.3),
                      widget.color.withOpacity(_isHovered ? 0.2 : 0.1),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Center(
                  child: AnimatedScale(
                    scale: _isHovered ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.phone_android,
                      size: 80,
                      color: widget.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmallScreen = constraints.maxWidth < 400;
                    return Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.color,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 10),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 13 : 15,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 20),
                          Wrap(
                            spacing: isSmallScreen ? 6 : 8,
                            runSpacing: isSmallScreen ? 6 : 8,
                            children: widget.tech.map((t) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 8 : 12,
                                  vertical: isSmallScreen ? 4 : 6,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: widget.color.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 10 : 12,
                                    color: widget.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    if (widget.codeLink != null) {
                                      final uri = Uri.parse(widget.codeLink!);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.code,
                                      size: isSmallScreen ? 16 : 18),
                                  label: Text(
                                      isSmallScreen ? 'Code' : 'View Code'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: widget.color,
                                  ),
                                ),
                              ),
                              SizedBox(width: isSmallScreen ? 8 : 16),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    if (widget.demoLink != null) {
                                      try {
                                        final uri = Uri.parse(widget.demoLink!);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(
                                            uri,
                                            mode: LaunchMode.platformDefault,
                                          );
                                        } else {
                                          // Fallback: try to open in new window
                                          await launchUrl(
                                            uri,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      } catch (e) {
                                        // If URL launcher fails, try with external application mode
                                        try {
                                          final uri =
                                              Uri.parse(widget.demoLink!);
                                          await launchUrl(
                                            uri,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } catch (e2) {
                                          print('Error launching URL: $e2');
                                        }
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.open_in_new,
                                      size: isSmallScreen ? 16 : 18),
                                  label: Text(
                                      isSmallScreen ? 'Demo' : 'Live Demo'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: widget.color,
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
