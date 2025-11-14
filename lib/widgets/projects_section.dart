import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatelessWidget {
  final AutoScrollController scrollController;

  const ProjectsSection({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'E-Commerce App',
        'description':
            'A full-featured e-commerce application with shopping cart, payment integration, and user authentication.',
        'tech': ['Flutter', 'Firebase', 'Stripe'],
        'color': Theme.of(context).colorScheme.primary,
      },
      {
        'title': 'Social Media App',
        'description':
            'A social networking app with real-time messaging, posts, and user profiles.',
        'tech': ['Flutter', 'Firebase', 'WebRTC'],
        'color': Theme.of(context).colorScheme.tertiary,
      },
      {
        'title': 'Weather App',
        'description':
            'Beautiful weather application with location-based forecasts and animated weather icons.',
        'tech': ['Flutter', 'REST API', 'Animations'],
        'color': Theme.of(context).colorScheme.secondary,
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
              return _ProjectCard(
                title: project['title'] as String,
                description: project['description'] as String,
                tech: project['tech'] as List<String>,
                color: project['color'] as Color,
                delay: 400 + (index * 200),
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

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tech,
    required this.color,
    required this.delay,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).textTheme.headlineMedium?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.tech.map((t) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
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
                              fontSize: 12,
                              color: widget.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.code, size: 18),
                          label: const Text('View Code'),
                          style: TextButton.styleFrom(
                            foregroundColor: widget.color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label: const Text('Live Demo'),
                          style: TextButton.styleFrom(
                            foregroundColor: widget.color,
                          ),
                        ),
                      ],
                    ),
                  ],
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
