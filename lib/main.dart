import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

/* ───────────────────── PALETTE ───────────────────── */

const Color kBg = Color(0xFF18190C); // deep olive background
const Color kText = Color(0xFF24160B); // warm ink brown
const Color kDeepGreen = Color(0xFF273417); // shadowy moss
const Color kLeaf = Color(0xFF6B8F3A); // bright mossy green
const Color kSoftGreen = Color(0xFF3B4F22); // muted mid-green
const Color kSun = Color(0xFFCFAF5B); // antique gold
const Color kParchment = Color(0xFFF3E4C6); // parchment surface
const Color kTeal = Color(0xFF2D7A6A); // bottle teal
const Color kRose = Color(0xFFB4575E); // dusty ruby;

void main() {
  // required for VisibilityDetector on some platforms
  VisibilityDetectorController.instance.updateInterval = const Duration(
    milliseconds: 100,
  );
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI/UX Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBg,
        textTheme: GoogleFonts.nunitoTextTheme().apply(
          bodyColor: kParchment,
          displayColor: kParchment,
        ),
        colorScheme: const ColorScheme.dark(
          primary: kLeaf,
          secondary: kSun,
          surface: kParchment,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLeaf,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            elevation: 6,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kParchment,
            side: BorderSide(color: kParchment.withOpacity(0.9)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: kSoftGreen,
          labelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

/* ───────────────────── PAGE ───────────────────── */

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          const GlobalFloatingBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 900;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _TopNav(isWide: isWide),
                      const SizedBox(height: 30),
                      HeroSection(isWide: isWide),
                      const SizedBox(height: 40),
                      _SectionWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 80),
                              child: const _AboutSection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 120),
                              child: const _ProjectsSection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 140),
                              child: const _ExperienceSection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 155),
                              child: const _CertificationsSection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 170),
                              child: const _SkillsSection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 185),
                              child: const _DesignGallerySection(),
                            ),
                            const SizedBox(height: 40),
                            ScrollFadeIn(
                              delay: const Duration(milliseconds: 200),
                              child: const _ContactSection(),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* ───────────────────── FLOATING SPARKLE BACKGROUND ───────────────────── */

class GlobalFloatingBackground extends StatefulWidget {
  const GlobalFloatingBackground({super.key});

  @override
  State<GlobalFloatingBackground> createState() =>
      _GlobalFloatingBackgroundState();
}

class _GlobalFloatingBackgroundState extends State<GlobalFloatingBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          return SizedBox.expand(
            child: Stack(
              children: [
                // subtle vignette
                Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.2),
                      radius: 1.1,
                      colors: [Color(0x2218180C), Color(0xFF18180C)],
                    ),
                  ),
                ),

                // scattered sparkles
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(-0.9, -0.7),
                  baseSize: 6,
                  color: kSun,
                  phase: 0.1,
                  drift: 14,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(-0.4, -0.3),
                  baseSize: 5,
                  color: kLeaf,
                  phase: 0.4,
                  drift: 10,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(0.2, -0.6),
                  baseSize: 7,
                  color: kTeal,
                  phase: 0.8,
                  drift: 16,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(0.8, -0.2),
                  baseSize: 5,
                  color: kRose,
                  phase: 1.2,
                  drift: 12,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(-0.7, 0.4),
                  baseSize: 4,
                  color: kSun,
                  phase: 1.5,
                  drift: 18,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(-0.1, 0.7),
                  baseSize: 6,
                  color: kLeaf,
                  phase: 1.9,
                  drift: 14,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(0.6, 0.5),
                  baseSize: 5,
                  color: kTeal,
                  phase: 2.3,
                  drift: 10,
                ),
                _BgSparkle(
                  t: t,
                  alignment: const Alignment(0.9, 0.9),
                  baseSize: 7,
                  color: kSun,
                  phase: 2.7,
                  drift: 18,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BgSparkle extends StatelessWidget {
  final double t;
  final Alignment alignment;
  final double baseSize;
  final Color color;
  final double phase;
  final double drift;

  const _BgSparkle({
    required this.t,
    required this.alignment,
    required this.baseSize,
    required this.color,
    required this.phase,
    required this.drift,
  });

  @override
  Widget build(BuildContext context) {
    final angle = (t + phase) * 2 * math.pi;
    final dx = math.sin(angle) * drift;
    final dy = math.cos(angle * 0.8) * drift;
    final twinkle = (math.sin(angle * 2) + 1) / 2; // 0..1
    final size = baseSize + twinkle * 2;
    final opacity = 0.25 + twinkle * 0.55;

    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: Offset(dx, dy),
        child: Transform.rotate(
          angle: angle,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(opacity),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(opacity * 0.8),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ───────────────────── TOP NAV ───────────────────── */

class _TopNav extends StatelessWidget {
  final bool isWide;
  const _TopNav({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 10),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: kSoftGreen,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: kSun.withOpacity(0.7),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: kSun,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Marianne Rhaleigh G. Paradero',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kParchment,
                          ),
                        ),
                        Text(
                          'UI/UX • Front-end Developer',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: kParchment.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isWide)
                  Row(
                    children: const [
                      _NavItem(label: 'About'),
                      _NavItem(label: 'Projects'),
                      _NavItem(label: 'Experience'),
                      _NavItem(label: 'Certifications'),
                      _NavItem(label: 'Skills'),
                      _NavItem(label: 'Designs'),
                      _NavItem(label: 'Contact'),
                    ],
                  ),
                if (!isWide)
                  const Icon(Icons.menu, color: kParchment, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  const _NavItem({required this.label});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _hovering ? kSoftGreen.withOpacity(0.9) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: _hovering ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: const Icon(Icons.star, size: 14, color: kSun),
            ),
            if (_hovering) const SizedBox(width: 6),
            Text(
              widget.label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                color: _hovering ? kParchment : kParchment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── HERO ───────────────────── */

class HeroSection extends StatefulWidget {
  final bool isWide;
  const HeroSection({required this.isWide, super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedBuilder(
            animation: _floatController,
            builder: (context, _) {
              final floatValue = _floatController.value;
              final movement = math.sin(floatValue * 2 * math.pi) * 14;
              final charmPhase = floatValue * 2 * math.pi;

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 36,
                  horizontal: 24,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = widget.isWide && constraints.maxWidth > 900;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: isWide ? 6 : 0,
                          child: Column(
                            crossAxisAlignment: isWide
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              ScrollFadeIn(
                                delay: const Duration(milliseconds: 80),
                                child: Text(
                                  'UI / UX DESIGNER',
                                  style: GoogleFonts.nunito(
                                    fontSize: 13,
                                    letterSpacing: 5,
                                    fontWeight: FontWeight.w800,
                                    color: kSun,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ScrollFadeIn(
                                delay: const Duration(milliseconds: 140),
                                child: Text(
                                  'Hello — I’m Rhaleigh.',
                                  textAlign: isWide
                                      ? TextAlign.left
                                      : TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: isWide ? 72 : 46,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                    color: kParchment,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 24,
                                        color: kSun.withOpacity(0.95),
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ScrollFadeIn(
                                delay: const Duration(milliseconds: 200),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 720,
                                  ),
                                  child: Text(
                                    'I’m a 4th year IT student who loves UI/UX design and frontend development —'
                                    ' still learning, but excited to contribute, grow with a team, and support real projects through an internship opportunity.',
                                    textAlign: isWide
                                        ? TextAlign.left
                                        : TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: kParchment.withOpacity(0.92),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ScrollFadeIn(
                                delay: const Duration(milliseconds: 280),
                                child: Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.grid_view_rounded),
                                      label: const Text(
                                        'View Academic Projects',
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.description),
                                      label: const Text('Download CV'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              ScrollFadeIn(
                                delay: const Duration(milliseconds: 340),
                                child: Wrap(
                                  spacing: 8,
                                  children: const [
                                    _HeroTag(label: 'UI/UX Design'),
                                    _HeroTag(label: 'Frontend Development'),
                                    _HeroTag(label: 'Design Systems'),
                                    _HeroTag(label: 'Prototyping'),
                                    _HeroTag(label: 'Internship-ready'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isWide) const SizedBox(width: 32),
                        if (isWide)
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 320,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: 24 + movement * 0.4,
                                    left: 18,
                                    child: Container(
                                      width: 86,
                                      height: 86,
                                      decoration: BoxDecoration(
                                        color: kSun,
                                        borderRadius: BorderRadius.circular(86),
                                        boxShadow: [
                                          BoxShadow(
                                            color: kSun.withOpacity(0.7),
                                            blurRadius: 28,
                                            spreadRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _FloatingCharmPainted(
                                    left: -6,
                                    top: 26 + math.sin(charmPhase) * 8,
                                    icon: Icons.star,
                                    size: 18,
                                    color: kSun,
                                    opacityBase: 0.9,
                                  ),
                                  _FloatingCharmPainted(
                                    right: 12,
                                    top: 100 + math.cos(charmPhase * 1.3) * 10,
                                    icon: Icons.circle,
                                    size: 12,
                                    color: kTeal,
                                    opacityBase: 0.85,
                                  ),
                                  _FloatingCharmPainted(
                                    left: 40,
                                    bottom: -8 + movement * 0.35,
                                    icon: Icons.diamond,
                                    size: 20,
                                    color: kRose,
                                    opacityBase: 0.92,
                                  ),
                                  _FloatingCharmPainted(
                                    right: -12,
                                    bottom:
                                        20 + math.sin(charmPhase * 0.7) * 12,
                                    icon: Icons.circle,
                                    size: 14,
                                    color: kLeaf,
                                    opacityBase: 0.9,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Transform.translate(
                                      offset: Offset(0, movement),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const CircleAvatar(
                                            radius: 72,
                                            backgroundColor: kBg,
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: kParchment,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'Your Illustration / Avatar',
                                            style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              color: kDeepGreen.withOpacity(
                                                0.82,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FloatingCharmPainted extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final IconData icon;
  final double size;
  final Color color;
  final double opacityBase;

  const _FloatingCharmPainted({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.icon,
    required this.size,
    required this.color,
    this.opacityBase = 0.8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Opacity(
        opacity: opacityBase,
        child: Icon(icon, size: size, color: color.withOpacity(0.96)),
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  final String label;
  const _HeroTag({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      backgroundColor: kSoftGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(color: kSun.withOpacity(0.8)),
      ),
    );
  }
}

/* ───────────────────── WRAPPER & SCROLL FADE ───────────────────── */

class _SectionWrapper extends StatelessWidget {
  final Widget child;
  const _SectionWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: child,
        ),
      ),
    );
  }
}

class ScrollFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  const ScrollFadeIn({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
    this.offsetY = 18,
    super.key,
  });

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _visibleTriggered = false;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _offset = Tween(
      begin: Offset(0, widget.offsetY / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _trigger() async {
    if (_visibleTriggered) return;
    _visibleTriggered = true;
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final key = ValueKey(widget.child.hashCode ^ widget.hashCode);
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.18) {
          _trigger();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, ch) {
          return Opacity(
            opacity: _opacity.value,
            child: FractionalTranslation(translation: _offset.value, child: ch),
          );
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/* ───────────────────── SECTION TITLE ───────────────────── */

class _SectionTitle extends StatelessWidget {
  final String label;
  final String tagline;
  final bool center;

  const _SectionTitle({
    required this.label,
    required this.tagline,
    this.center = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.nunito(
            fontSize: 13,
            letterSpacing: 3,
            color: kParchment.withOpacity(0.7),
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 6),
        Text(
          tagline,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: kParchment,
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

/* ───────────────────── ABOUT ───────────────────── */

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _SectionTitle(
              label: 'About Me',
              tagline:
                  'Designing interfaces while growing in UI/UX and front-end development.',
              center: true,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(32, 22, 32, 26),
              decoration: BoxDecoration(
                color: kParchment,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: kSun.withOpacity(0.4)),
              ),
              child: Text(
                'I’m an Information Technology student specializing in front-end development and UI/UX design.\n'
                'I enjoy turning messy ideas into clear, user-friendly interfaces for both web and mobile experiences.\n'
                'I’m passionate about creating responsive designs and I’m also knowledgeable in publicity materials such as posters,\n'
                'announcements, and social media posts. I’m eager to apply my technical and creative skills through an internship\n'
                'that encourages learning, collaboration, and thoughtful, visually cohesive design.',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  height: 1.8,
                  color: kText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── PROJECTS ───────────────────── */

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      const ProjectCardData(
        title:
            'RESFORCE: Army Reserve Record Management System for 402nd Community Defense Center',
        description:
            'A web-based record management system for the Army Reserve Command, helping automate reservist profiles, unit assignments, and document tracking.',
        tags: ['Web app', 'Record Management', 'Information System'],
        role: 'Front-end / UI/UX Designer',
        timeframe: '2024 • Capstone system',
        caseStudyUrl: 'https://resforce.info',
        imageAsset: 'assets/resforce_ui.png',
      ),
      const ProjectCardData(
        title:
            'EPASS: Electronic Permit Application and Submission System for LPU–Cavite',
        description:
            'An online permit processing system for students and offices, streamlining event and activity requests, approvals, and documentation.',
        tags: ['Web app', 'Workflow', 'University'],
        role: 'UI/UX Designer • Front-end Support',
        timeframe: '2024 • Academic project',
        caseStudyUrl: 'https://example.com/epass',
        imageAsset: 'assets/epass_ui.png',
      ),
      const ProjectCardData(
        title: 'StockUp – Inventory Management System',
        description:
            'An inventory management interface designed to help track stocks, movements, and low-quantity alerts for small businesses and organizations.',
        tags: ['Inventory', 'Dashboard', 'Web app'],
        role: 'UI/UX Designer',
        timeframe: '2023 • Academic prototype',
        caseStudyUrl: null,
        imageAsset: 'assets/stockup_ui.png',
      ),
      const ProjectCardData(
        title: 'PawCentral PH: Pet Care Management Platform',
        description:
            'A concept platform for pet owners and clinics with QR-tagged pet profiles, vet visit tracking, and lost-and-found coordination flows.',
        tags: ['Mobile app', 'UX Flows', 'Concept'],
        role: 'Product / UI/UX Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: null,
        imageAsset: 'assets/pawcentral_ui.png',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Academic Projects',
          tagline: 'Published systems and prototype designs.',
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;

            return Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                spacing: 18,
                runSpacing: 18,
                children: projects.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final data = entry.value;

                  final double width = isWide
                      ? (constraints.maxWidth - 18) / 2
                      : constraints.maxWidth;

                  return SizedBox(
                    width: width,
                    child: ScrollFadeIn(
                      delay: Duration(milliseconds: 80 + idx * 120),
                      child: HoverCard(
                        child: _ProjectCardInteractive(data: data),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProjectCardData {
  final String title;
  final String description;
  final List<String> tags;
  final String? role;
  final String? timeframe;
  final String? caseStudyUrl;
  final String? imageAsset;

  const ProjectCardData({
    required this.title,
    required this.description,
    required this.tags,
    this.role,
    this.timeframe,
    this.caseStudyUrl,
    this.imageAsset,
  });
}

class _ProjectCardInteractive extends StatelessWidget {
  final ProjectCardData data;
  const _ProjectCardInteractive({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showProjectDialog(context, data),
      child: ProjectCard(data: data),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectCardData data;
  const ProjectCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kSun.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.imageAsset != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                data.imageAsset!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            data.title,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: kDeepGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.description,
            style: GoogleFonts.nunito(
              fontSize: 12,
              height: 1.6,
              color: kText.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: data.tags
                .map(
                  (t) => Chip(
                    label: Text(t, style: const TextStyle(fontSize: 11)),
                    backgroundColor: kSoftGreen,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

void _showProjectDialog(BuildContext context, ProjectCardData data) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: kParchment,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: kDeepGreen,
                    ),
                  ),
                  if (data.role != null || data.timeframe != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      [
                        if (data.role != null) data.role!,
                        if (data.timeframe != null) data.timeframe!,
                      ].join(' • '),
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: kText.withOpacity(0.7),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Text(
                    data.description,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      height: 1.7,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: data.tags
                        .map(
                          (t) => Chip(
                            label: Text(
                              t,
                              style: const TextStyle(fontSize: 11),
                            ),
                            backgroundColor: kSoftGreen,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Use this space to write your full case study: problem, research, flows, wireframes, and outcomes.\n'
                    'You can also link to a Figma prototype or Behance/Dribbble case study below.',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      height: 1.6,
                      color: kText.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (data.caseStudyUrl != null)
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: open link with url_launcher
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Open full case study'),
                    )
                  else
                    Text(
                      'Tip: attach your real case study link here (Figma, Behance, Notion, etc.).',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: kText.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/* ───────────────────── EXPERIENCE ───────────────────── */

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _TimelineItem(
        title: 'Department of Science and Technology (DOST) Scholar',
        subtitle: 'RA 7687 DOST-SEI Scholar • 2022 – Present',
        details:
            'Government-funded science and technology scholarship awarded for academic performance and STEM potential, maintained through consistent grades and active engagement in IT-related coursework.',
      ),
      _TimelineItem(
        title: 'BS Information Technology (Student)',
        subtitle:
            'Lyceum of the Philippines University – Cavite • 2022 – Present',
        details:
            'Focusing on front-end development and UI/UX design, with academic projects in web-based systems, usability, and interface design for real-world school and organizational workflows.',
      ),
      _TimelineItem(
        title: 'LPU Resident-Partial Scholar',
        subtitle:
            'Lyceum of the Philippines University – Cavite • 2022–2023 & 2024–2025',
        details:
            'University-funded scholarship granted for academic standing and campus involvement, balancing scholarship responsibilities with coursework, capstone development, and creative work.',
      ),
      _TimelineItem(
        title: 'Dean’s List Student',
        subtitle:
            'Lyceum of the Philippines University – Cavite • 2022 – Present',
        details:
            'Consistently recognized on the Dean’s List for maintaining high academic performance across IT, design-related, and technical subjects.',
      ),
      _TimelineItem(
        title: 'Creative Committee Member',
        subtitle: 'Lyceum of the Philippines University – Cavite • 2024',
        details:
            'Contributed designs for publicity materials such as posters, announcements, and social media posts, aligning visuals with event themes and organization branding.',
      ),
      _TimelineItem(
        title: 'Emilio Aguinaldo College – Cavite',
        subtitle: 'With Academic High Honors • 2020 – 2022',
        details:
            'Graduated with academic high honors in Senior High School while actively participating in school activities and developing interest in design and technology.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Experience',
          tagline: 'Education & involvement.',
        ),
        const SizedBox(height: 6),
        Column(
          children: items.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ScrollFadeIn(
                delay: Duration(milliseconds: 80 + idx * 90),
                child: _TimelineTile(item: item),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TimelineItem {
  final String title;
  final String subtitle;
  final String details;

  _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineItem item;
  const _TimelineTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kParchment,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kSun.withOpacity(0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kLeaf,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kDeepGreen,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: kText.withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.details,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      height: 1.6,
                      color: kText.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── CERTIFICATIONS & COMPETITIONS ───────────────────── */

class _CertificationsSection extends StatelessWidget {
  const _CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certs = [
      _CertificationItem(
        title: 'IT Specialist – HTML and CSS',
        issuer: 'Certiport',
        year: '2025',
        details:
            'Industry-recognized certification validating foundational skills in semantic HTML, CSS styling, layouts, and responsive web design.',
        imageAsset: 'assets/certs/it_specialist_html_css.png',
      ),
      _CertificationItem(
        title: 'CCNA: Introduction to Networks',
        issuer: 'LPU–Cavite • Cisco Networking Academy',
        year: '2025',
        details:
            'Coursework covering networking fundamentals, IP addressing, subnetting, basic routing and switching, and the OSI model.',
        imageAsset: 'assets/certs/ccna_intro_networks.png',
      ),
      _CertificationItem(
        title: 'UNESCO Youth Hackathon 2025 – Delegate',
        issuer: 'UNESCO Philippines',
        year: '2024',
        details:
            'Represented as a student delegate, collaborating with a team to ideate and design digital solutions for youth- and community-focused challenges.',
        imageAsset: 'assets/certs/unesco_hackathon_delegate.png',
      ),
      _CertificationItem(
        title:
            'NextGenPH: Youth Innovators Reimagining Public Service – Delegate',
        issuer: 'Development Academy of the Philippines',
        year: '2022–2024',
        details:
            'Engaged in sessions on governance, innovation, and public service, contributing ideas on how technology and design can support civic initiatives.',
        imageAsset: 'assets/certs/nextgenph_delegate.png',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Certifications & Competitions',
          tagline: 'Learning beyond the classroom.',
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: certs
              .asMap()
              .entries
              .map(
                (entry) => SizedBox(
                  width: 360,
                  child: ScrollFadeIn(
                    delay: Duration(milliseconds: 80 + entry.key * 80),
                    child: HoverCard(
                      child: _CertificationTile(item: entry.value),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CertificationItem {
  final String title;
  final String issuer;
  final String year;
  final String details;
  final String? imageAsset; // 👈 new

  _CertificationItem({
    required this.title,
    required this.issuer,
    required this.year,
    required this.details,
    this.imageAsset,
  });
}

class _CertificationTile extends StatelessWidget {
  final _CertificationItem item;
  const _CertificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showCertificationDialog(context, item),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kParchment,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kSun.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: kDeepGreen,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${item.issuer} • ${item.year}',
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: kText.withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.details,
              style: GoogleFonts.nunito(
                fontSize: 12,
                height: 1.6,
                color: kText.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── CERT MODAL ───────────────────── */

void _showCertificationDialog(BuildContext context, _CertificationItem item) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: kParchment,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 600,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title + close
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kDeepGreen,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: kText),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${item.issuer} • ${item.year}',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: kText.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: item.imageAsset != null
                        ? Image.asset(
                            item.imageAsset!,
                            fit: BoxFit.contain,
                          )
                        : Center(
                            child: Text(
                              'Certificate preview coming soon.',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: kText.withOpacity(0.7),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


/* ───────────────────── SKILLS ───────────────────── */

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final designTools = ['Figma', 'Canva', 'Basic Adobe Photoshop'];
    final devTools = ['HTML/CSS', 'Basic JS', 'Basic Flutter/Dart', 'Git', 'VS Code', 'Github'];
    final softSkills = [
      'Collaboration',
      'Problem-solving',
      'Communication',
      'Attention to detail',
      'Attention to detail',
      'Attention to detail',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Skills',
          tagline: 'What I bring to a team.',
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            ScrollFadeIn(
              delay: const Duration(milliseconds: 80),
              child: _SkillGroup(title: 'Design tools', items: designTools),
            ),
            ScrollFadeIn(
              delay: const Duration(milliseconds: 120),
              child: _SkillGroup(title: 'Development', items: devTools),
            ),
            ScrollFadeIn(
              delay: const Duration(milliseconds: 160),
              child: _SkillGroup(title: 'Soft skills', items: softSkills),
            ),
          ],
        ),
      ],
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const _SkillGroup({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: HoverCard(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kParchment,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: kSun.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kDeepGreen,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items
                    .map(
                      (i) => Chip(
                        label: Text(i, style: const TextStyle(fontSize: 11)),
                        backgroundColor: kSoftGreen,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────────── DESIGN GALLERY – CAROUSEL ───────────────────── */

class _DesignGallerySection extends StatefulWidget {
  const _DesignGallerySection({super.key});

  @override
  State<_DesignGallerySection> createState() => _DesignGallerySectionState();
}

class _DesignGallerySectionState extends State<_DesignGallerySection> {
  late final PageController _pageController;
  double _page = 0;

  final List<_DesignShot> _shots = const [
    _DesignShot(
      title: 'Analytics Dashboard UI',
      description:
          'A clean analytics layout exploring cards, charts, and subtle color accents.',
      imageAsset: 'assets/design_dashboard.png',
    ),
    _DesignShot(
      title: 'Mobile Onboarding Flow',
      description:
          'Soft, friendly onboarding screens for a concept mobile app experience.',
      imageAsset: 'assets/design_onboarding.png',
    ),
    _DesignShot(
      title: 'Landing Page Hero Section',
      description:
          'Hero section exploration with large typography, CTA buttons, and supporting visuals.',
      imageAsset: 'assets/design_landing.png',
    ),
    _DesignShot(
      title: 'Poster / PubMat Layout',
      description:
          'Publicity material design used for announcements and event promotions.',
      imageAsset: 'assets/design_poster.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.78);
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Design Gallery',
          tagline: 'Selected UI explorations & pubmats.',
          center: true,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _shots.length,
            itemBuilder: (context, index) {
              final shot = _shots[index];
              final distance = (index - _page).abs();
              final scale = 1 - (distance * 0.15).clamp(0.0, 0.3);
              final opacity = 1 - (distance * 0.3).clamp(0.0, 0.5);

              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: HoverCard(
                      child: _DesignCard(shot: shot),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              _shots.length,
              (i) {
                final isActive = (_page.round() == i);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: isActive ? 20 : 8,
                  decoration: BoxDecoration(
                    color:
                        isActive ? kSun : kParchment.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DesignShot {
  final String title;
  final String description;
  final String imageAsset;

  const _DesignShot({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}

class _DesignCard extends StatelessWidget {
  final _DesignShot shot;
  const _DesignCard({required this.shot});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: kSun.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              shot.imageAsset,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shot.title,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kDeepGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  shot.description,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    height: 1.6,
                    color: kText.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ───────────────────── CONTACT ───────────────────── */

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(label: 'Contact', tagline: 'Let’s work together.'),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: kParchment,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kSun.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I’m open to UI/UX internship opportunities (on-site, hybrid, or remote).',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  height: 1.6,
                  color: kText,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: const [
                  _ContactChip(
                    icon: Icons.email,
                    label: 'youremail@example.com',
                  ),
                  _ContactChip(
                    icon: Icons.link,
                    label: 'Behance / Dribbble / Portfolio link',
                  ),
                  _ContactChip(
                    icon: Icons.location_on,
                    label: 'Your City, Country',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Text(
            '© $year Your Name • UI/UX & Front-end',
            style: GoogleFonts.nunito(
              fontSize: 11,
              color: kParchment.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ContactChip({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: kLeaf),
      label: Text(label, style: const TextStyle(fontSize: 11)),
      backgroundColor: kSoftGreen,
    );
  }
}

/* ───────────────────── HOVER CARD ───────────────────── */

class HoverCard extends StatefulWidget {
  final Widget child;
  const HoverCard({required this.child, super.key});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}
