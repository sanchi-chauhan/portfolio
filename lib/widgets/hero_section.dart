import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  final AutoScrollController scrollController;

  const HeroSection({
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
    return Container(
      height: MediaQuery.of(context).size.height,
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
      child: Stack(
        children: [
          // Animated background shapes
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                duration: 3000.ms,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                duration: 4000.ms,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3)),
          ),
          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width > 600 ? 120 : 60,
                right: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, I\'m',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.3, end: 0),
                  const SizedBox(height: 16),
                  _TypingNameText(
                    text: 'Sanchi Chauhan',
                    fontSize: MediaQuery.of(context).size.width > 600 ? 80 : 48,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 200.ms)
                      .slideY(begin: -0.3, end: 0),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 36 : 28,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                          height: 1.2,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 400.ms)
                          .slideX(begin: -0.3, end: 0),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .fadeIn(duration: 500.ms)
                          .then()
                          .fadeOut(duration: 500.ms),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600
                        ? 600
                        : double.infinity,
                    child: Text(
                      'Passionate Flutter developer with 3 years of experience creating beautiful, performant mobile and web applications.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        height: 1.6,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
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
                        child: ElevatedButton(
                          onPressed: () =>
                              _scrollToSection(3), // Contact section
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get In Touch',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 800.ms)
                          .scale(delay: 800.ms),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: OutlinedButton(
                          onPressed: () =>
                              _scrollToSection(2), // Projects section
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).textTheme.bodyLarge?.color,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Projects',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1000.ms)
                          .scale(delay: 1000.ms),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingNameText extends StatefulWidget {
  final String text;
  final double fontSize;

  const _TypingNameText({
    required this.text,
    required this.fontSize,
  });

  @override
  State<_TypingNameText> createState() => _TypingNameTextState();
}

class _TypingNameTextState extends State<_TypingNameText>
    with TickerProviderStateMixin {
  String displayedText = '';
  int currentIndex = 0;
  bool showCursor = true;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _startTyping();
  }

  void _startTyping() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _typeNextCharacter();
    });
  }

  void _typeNextCharacter() {
    if (currentIndex < widget.text.length) {
      setState(() {
        displayedText += widget.text[currentIndex];
        currentIndex++;
      });
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          _typeNextCharacter();
        }
      });
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.tertiary,
        ],
      ).createShader(bounds),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                displayedText,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                  letterSpacing: -1,
                ),
                overflow: TextOverflow.visible,
                softWrap: false,
              ),
            ),
            AnimatedBuilder(
              animation: _cursorController,
              builder: (context, child) {
                return Opacity(
                  opacity: _cursorController.value,
                  child: Text(
                    '_',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: -1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
