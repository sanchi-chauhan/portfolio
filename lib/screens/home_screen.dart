import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../main.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AutoScrollController scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = scrollController.offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(0),
                  controller: scrollController,
                  index: 0,
                  child: HeroSection(
                    scrollController: scrollController,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(1),
                  controller: scrollController,
                  index: 1,
                  child: AboutSection(
                    scrollController: scrollController,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(2),
                  controller: scrollController,
                  index: 2,
                  child: ProjectsSection(
                    scrollController: scrollController,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(3),
                  controller: scrollController,
                  index: 3,
                  child: ContactSection(
                    scrollController: scrollController,
                  ),
                ),
              ),
            ],
          ),
          // Firefly - only show when first screen is 100% visible (scroll at top)
          if (_scrollOffset <= 50)
            _Firefly(
              key: const ValueKey('firefly'),
              delay: 0,
              scrollOffset: _scrollOffset,
            ),
        ],
      ),
    );
  }
}

class _Firefly extends StatefulWidget {
  final int delay;
  final double scrollOffset;

  const _Firefly({
    super.key,
    required this.delay,
    required this.scrollOffset,
  });

  @override
  State<_Firefly> createState() => _FireflyState();
}

class _FireflyState extends State<_Firefly> with TickerProviderStateMixin {
  late AnimationController _movementController;
  late AnimationController _glowController;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Movement controller - a bit faster
    _movementController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 35000),
    );

    // Start animation with delay for each firefly
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _movementController.repeat();
      }
    });

    // Glow controller - slower blinking
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Create smooth flying path - very slow, favoring right side
    // Use delay to create different starting positions
    final startX = (widget.delay * 137.5) % 1000;
    _xAnimation = Tween<double>(
      begin: startX,
      end: startX + 2000.0,
    ).animate(CurvedAnimation(
      parent: _movementController,
      curve: Curves.linear,
    ));

    // Create wavy vertical movement - very slow
    // Use delay to create different starting positions
    final startY = (widget.delay * 97.3) % 600;
    _yAnimation = Tween<double>(
      begin: startY,
      end: startY + 800.0,
    ).animate(CurvedAnimation(
      parent: _movementController,
      curve: Curves.linear,
    ));

    // Blinking opacity animation - slower
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Subtle scale animation for pulsing effect - slower
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.9), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _movementController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: Listenable.merge([_movementController, _glowController]),
      builder: (context, child) {
        // Keep firefly more on the right side of screen
        // Map animation value to favor right side (70-95% of screen width)
        final normalizedValue = (_xAnimation.value % 2000) / 2000;
        final rightSideBias =
            0.7 + (normalizedValue * 0.25); // 70% to 95% of screen
        final x = (screenWidth * rightSideBias).clamp(0.0, screenWidth - 30);
        final y = 100 + ((_yAnimation.value % (screenHeight - 200)) * 0.5);

        return Positioned(
          left: x,
          top: y,
          child: Tooltip(
            message: 'Click to change theme',
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            textStyle: TextStyle(
              color: Theme.of(context).textTheme.displaySmall?.color,
              fontSize: 12,
            ),
            child: GestureDetector(
              onTap: () {
                MyApp.of(context)?.toggleTheme();
              },
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(1.0),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                          blurRadius: 25,
                          spreadRadius: 6,
                        ),
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.4),
                          blurRadius: 35,
                          spreadRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
