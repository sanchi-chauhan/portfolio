import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class CustomNavigationBar extends StatelessWidget {
  final AutoScrollController scrollController;

  const CustomNavigationBar({
    super.key,
    required this.scrollController,
  });

  void _scrollToSection(int index) {
    scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.95),
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background.withOpacity(0.95),
              Theme.of(context).colorScheme.surface.withOpacity(0.95),
            ],
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'SC',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                tooltip: Theme.of(context).brightness == Brightness.dark
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
                onPressed: () {
                  MyApp.of(context)?.toggleTheme();
                },
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms)
                  .scale(delay: 100.ms),
            ],
          ),
          if (MediaQuery.of(context).size.width > 600)
            Row(
              children: [
                _NavItem(
                  label: 'Home',
                  onTap: () => _scrollToSection(0),
                ),
                _NavItem(
                  label: 'About',
                  onTap: () => _scrollToSection(1),
                ),
                _NavItem(
                  label: 'Projects',
                  onTap: () => _scrollToSection(2),
                ),
                _NavItem(
                  label: 'Contact',
                  onTap: () => _scrollToSection(3),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 300.ms)
                .slideX(begin: 0.2, end: 0)
          else
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                // Mobile menu
              },
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ),
    );
  }
}
