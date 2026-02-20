import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool _showFirefly = true;
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());
  Timer? _snapDebounce;
  bool _isAutoSnapping = false;
  int? _snappedSection;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final shouldShowFirefly = scrollController.offset <= 50;
    if (shouldShowFirefly != _showFirefly) {
      setState(() {
        _showFirefly = shouldShowFirefly;
      });
    }
    if (_isAutoSnapping) return;
    _scheduleSnapCheck();
  }

  void _scheduleSnapCheck() {
    _snapDebounce?.cancel();
    _snapDebounce = Timer(const Duration(milliseconds: 120), _evaluateSnapTarget);
  }

  Future<void> _evaluateSnapTarget() async {
    if (!mounted || _isAutoSnapping) return;
    final viewportHeight = MediaQuery.of(context).size.height;
    int targetIndex = -1;
    double bestCoverage = 0.0;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final sectionContext = _sectionKeys[i].currentContext;
      if (sectionContext == null) continue;
      final renderObject = sectionContext.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.attached) continue;

      final top = renderObject.localToGlobal(Offset.zero).dy;
      final bottom = top + renderObject.size.height;
      final visibleTop = math.max(top, 0.0);
      final visibleBottom = math.min(bottom, viewportHeight);
      final visibleHeight = math.max(0.0, visibleBottom - visibleTop);
      final coverage = visibleHeight / viewportHeight;

      if (coverage > bestCoverage) {
        bestCoverage = coverage;
        targetIndex = i;
      }
    }

    if (targetIndex == -1 || bestCoverage < 0.55) return;
    if (_snappedSection == targetIndex) return;

    final targetContext = _sectionKeys[targetIndex].currentContext;
    if (targetContext == null) return;
    final targetRenderObject = targetContext.findRenderObject();
    if (targetRenderObject is! RenderBox || !targetRenderObject.attached) return;
    final viewport = RenderAbstractViewport.of(targetRenderObject);
    final rawOffset = viewport.getOffsetToReveal(targetRenderObject, 0.0).offset;
    final targetOffset = rawOffset
        .clamp(
          scrollController.position.minScrollExtent,
          scrollController.position.maxScrollExtent,
        )
        .toDouble();

    if ((scrollController.offset - targetOffset).abs() < 1.0) {
      _snappedSection = targetIndex;
      return;
    }

    _isAutoSnapping = true;
    try {
      await scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _snappedSection = targetIndex;
    } finally {
      _isAutoSnapping = false;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    _snapDebounce?.cancel();
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
                  child: KeyedSubtree(
                    key: _sectionKeys[0],
                    child: HeroSection(
                      scrollController: scrollController,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(1),
                  controller: scrollController,
                  index: 1,
                  child: KeyedSubtree(
                    key: _sectionKeys[1],
                    child: AboutSection(
                      scrollController: scrollController,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(2),
                  controller: scrollController,
                  index: 2,
                  child: KeyedSubtree(
                    key: _sectionKeys[2],
                    child: ProjectsSection(
                      scrollController: scrollController,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(3),
                  controller: scrollController,
                  index: 3,
                  child: KeyedSubtree(
                    key: _sectionKeys[3],
                    child: ContactSection(
                      scrollController: scrollController,
                    ),
                  ),
                ),
              ),
              // Footer at the very bottom
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Built with Flutter and heart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Built using ',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const FlutterLogo(
                            size: 16,
                          ),
                          Text(
                            ' with much ',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Copyright
                      Text(
                        '© 2026 Sanchi Chauhan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              ],
          ),
          // Firefly - only show when first screen is 100% visible (scroll at top)
          if (_showFirefly)
            _Firefly(
              key: const ValueKey('firefly'),
              delay: 0,
              scrollOffset: scrollController.hasClients ? scrollController.offset : 0,
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
