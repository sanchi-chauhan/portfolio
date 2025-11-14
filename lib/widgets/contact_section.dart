import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final AutoScrollController scrollController;

  const ContactSection({
    super.key,
    required this.scrollController,
  });

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
          Text(
            'Get In Touch',
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
          const SizedBox(height: 24),
          Text(
            'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your visions.',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 400.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 600;
              return SizedBox(
                width: constraints.maxWidth,
                child: Wrap(
                  spacing: isDesktop ? 24 : 16,
                  runSpacing: isDesktop ? 24 : 16,
                  alignment: WrapAlignment.center,
                  children: [
                  _ContactCard(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'your.email@example.com',
                    onTap: () => _launchURL('mailto:your.email@example.com'),
                    color: Theme.of(context).colorScheme.primary,
                    delay: 600,
                    isDesktop: isDesktop,
                  ),
                  _ContactCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '+1 (555) 123-4567',
                    onTap: () => _launchURL('tel:+15551234567'),
                    color: Theme.of(context).colorScheme.tertiary,
                    delay: 800,
                    isDesktop: isDesktop,
                  ),
                  _ContactCard(
                    icon: Icons.link,
                    title: 'LinkedIn',
                    subtitle: 'linkedin.com/in/yourprofile',
                    onTap: () => _launchURL('https://linkedin.com/in/yourprofile'),
                    color: Theme.of(context).colorScheme.secondary,
                    delay: 1000,
                    isDesktop: isDesktop,
                  ),
                  _ContactCard(
                    icon: Icons.code,
                    title: 'GitHub',
                    subtitle: 'github.com/yourusername',
                    onTap: () => _launchURL('https://github.com/yourusername'),
                    color: Theme.of(context).colorScheme.primary,
                    delay: 1200,
                    isDesktop: isDesktop,
                  ),
                ],
                ),
              );
            },
          ),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Let\'s work together!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 1400.ms)
                    .scale(delay: 1400.ms),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _launchURL('mailto:your.email@example.com'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Send Message',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 1600.ms)
                    .scale(delay: 1600.ms),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '© 2024 Sanchi Chauhan. All rights reserved.',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 1800.ms),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final int delay;
  final bool isDesktop;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    required this.delay,
    required this.isDesktop,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.isDesktop ? 250 : null,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(24),
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -8.0 : 0.0),
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? widget.color
                  : widget.color.withOpacity(0.3),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.color,
                      widget.color.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.color.withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: AnimatedScale(
                  scale: _isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: widget.delay.ms)
        .scale(delay: widget.delay.ms);
  }
}

