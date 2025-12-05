import 'dart:math' as math;
import 'dart:async';
import 'dart:html' as html; // web-only (ok for Flutter web builds)

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

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

// ───────────────────── LINKS / EXTERNAL URLS ─────────────────────

// Kept for reference; actual CV download uses downloadCvAsset()
const String kCvUrl = 'assets/cv/paradero_cv.pdf';
const String kGithubProfileUrl = 'https://github.com/rhaleighp15';

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
      title: 'Rhaleigh Paradero’s Portfolio',
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

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _designsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  void _onNavTap(String label) {
    switch (label) {
      case 'About':
        _scrollTo(_aboutKey);
        break;
      case 'Projects':
        _scrollTo(_projectsKey);
        break;
      case 'Experience':
        _scrollTo(_experienceKey);
        break;
      case 'Certifications':
        _scrollTo(_certsKey);
        break;
      case 'Skills':
        _scrollTo(_skillsKey);
        break;
      case 'Designs':
        _scrollTo(_designsKey);
        break;
      case 'Contact':
        _scrollTo(_contactKey);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  controller: _scrollController,
                  child: Column(
                    children: [
                      _TopNav(isWide: isWide, onNavTap: _onNavTap),
                      const SizedBox(height: 30),
                      HeroSection(
                        isWide: isWide,
                        onViewProjects: () => _scrollTo(_projectsKey),
                        // 🔽 use asset download for CV
                        onDownloadCv: downloadCvAsset,
                      ),
                      const SizedBox(height: 40),
                      _SectionWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionAnchor(
                              key: _aboutKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 80),
                                child: const _AboutSection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _projectsKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 120),
                                child: const _ProjectsSection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _experienceKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 140),
                                child: const _ExperienceSection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _certsKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 155),
                                child: const _CertificationsSection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _skillsKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 170),
                                child: const _SkillsSection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _designsKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 185),
                                child: const _DesignGallerySection(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SectionAnchor(
                              key: _contactKey,
                              child: ScrollFadeIn(
                                delay: const Duration(milliseconds: 200),
                                child: const _ContactSection(),
                              ),
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
  final void Function(String label)? onNavTap;

  const _TopNav({required this.isWide, this.onNavTap});

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
                    children: [
                      _NavItem(
                        label: 'About',
                        onTap: () => onNavTap?.call('About'),
                      ),
                      _NavItem(
                        label: 'Projects',
                        onTap: () => onNavTap?.call('Projects'),
                      ),
                      _NavItem(
                        label: 'Experience',
                        onTap: () => onNavTap?.call('Experience'),
                      ),
                      _NavItem(
                        label: 'Certifications',
                        onTap: () => onNavTap?.call('Certifications'),
                      ),
                      _NavItem(
                        label: 'Skills',
                        onTap: () => onNavTap?.call('Skills'),
                      ),
                      _NavItem(
                        label: 'Designs',
                        onTap: () => onNavTap?.call('Designs'),
                      ),
                      _NavItem(
                        label: 'Contact',
                        onTap: () => onNavTap?.call('Contact'),
                      ),
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
  final VoidCallback? onTap;

  const _NavItem({required this.label, this.onTap});

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
      child: GestureDetector(
        onTap: widget.onTap,
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
                  color: kParchment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────────── HERO ───────────────────── */

class HeroSection extends StatefulWidget {
  final bool isWide;
  final VoidCallback? onViewProjects;
  final VoidCallback? onDownloadCv;

  const HeroSection({
    required this.isWide,
    this.onViewProjects,
    this.onDownloadCv,
    super.key,
  });

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
                    final bool isWide =
                        widget.isWide && constraints.maxWidth > 900;

                    // ─── TEXT COLUMN (shared) ───
                    Widget buildTextColumn({required bool alignLeft}) {
                      final crossAxis = alignLeft
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center;
                      final textAlign =
                          alignLeft ? TextAlign.left : TextAlign.center;

                      return Column(
                        crossAxisAlignment: crossAxis,
                        children: [
                          ScrollFadeIn(
                            delay: const Duration(milliseconds: 80),
                            child: Text(
                              'UI / UX DESIGNER',
                              textAlign: textAlign,
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
                              textAlign: textAlign,
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
                                textAlign: textAlign,
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
                              alignment: alignLeft
                                  ? WrapAlignment.start
                                  : WrapAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: widget.onViewProjects,
                                  icon: const Icon(
                                    Icons.grid_view_rounded,
                                  ),
                                  label: const Text(
                                    'View Academic Projects',
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: widget.onDownloadCv,
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
                              alignment: alignLeft
                                  ? WrapAlignment.start
                                  : WrapAlignment.center,
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
                      );
                    }

                    // ─── ILLUSTRATION (shared) ───
                    Widget buildIllustration({required double height}) {
                      return SizedBox(
                        height: height,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // glowing sun
                            Positioned(
                              top: 40 + movement * 0.3,
                              right: 40,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSun,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kSun.withOpacity(0.7),
                                      blurRadius: 60,
                                      spreadRadius: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // floating charms
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
                              bottom: 20 + math.sin(charmPhase * 0.7) * 12,
                              icon: Icons.circle,
                              size: 14,
                              color: kLeaf,
                              opacityBase: 0.9,
                            ),

                            // illustration (clickable)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Transform.translate(
                                offset: Offset(0, movement * 0.4),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showZoomImageDialog(
                                            context,
                                            'assets/profile/rhaleigh.png',
                                            caption:
                                                'Marianne Rhaleigh G. Paradero',
                                          );
                                        },
                                        child: SizedBox(
                                          height: height - 30,
                                          child: Image.asset(
                                            'assets/profile/drawing.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Marianne Rhaleigh G. Paradero',
                                        style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          color: kParchment.withOpacity(
                                            0.75,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // ─── LAYOUT SWITCH ───
                    if (isWide) {
                      // Desktop / large screens: Row
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: buildTextColumn(alignLeft: true),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            flex: 4,
                            child: buildIllustration(height: 420),
                          ),
                        ],
                      );
                    } else {
                      // Mobile / narrow: Column
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildTextColumn(alignLeft: false),
                          const SizedBox(height: 28),
                          buildIllustration(height: 320),
                        ],
                      );
                    }
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
  const _HeroTag({required this.label});

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

/* ───────────────────── WRAPPER, ANCHOR & SCROLL FADE ───────────────────── */

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

class SectionAnchor extends StatelessWidget {
  final Widget child;

  const SectionAnchor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
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
  const _AboutSection();

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
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final projects = [
      const ProjectCardData(
        title:
            'ResForce: Army Reserve Record Management System for 402nd Community Defense Center',
        description:
            'A web-based record management system for the Army Reserve Command, helping automate reservist profiles, unit assignments, and document tracking.',
        tags: [
          'Web app',
          'Record Management',
          'Information System',
          '402nd CDC',
        ],
        role: 'Front-end / UI/UX Designer',
        timeframe: '2024 • Capstone system',
        caseStudyUrl: 'https://resforce.info',
        gallery: [
          'assets/resforce/resforce_1.png',
          'assets/resforce/resforce_2.png',
          'assets/resforce/resforce_3.png',
          'assets/resforce/resforce_4.png',
          'assets/resforce/resforce_5.png',
          'assets/resforce/resforce_6.png',
          'assets/resforce/resforce_7.png',
          'assets/resforce/resforce_8.png',
        ],
        galleryCaptions: {
          0: 'Capstone project developed for the 402nd Community Defense Center in Tanza, designed to modernize enlistment and reservist record management.',
          1: 'Fully hosted web-based system featuring online enlistment, unit organization, profile records, and document tracking accessible via any browser.',
          2: 'Developed using HTML5, CSS3, JavaScript, Node.js (Express), and Firebase as the core technologies supporting the RESFORCE platform.',
        },
      ),
      const ProjectCardData(
        title:
            'EPASS: Electronic Permit Application and Submission System for LPU–Cavite',
        description:
            'An online permit processing system for students and offices, streamlining event and activity requests, approvals, and documentation.',
        tags: ['Web app', 'Tracking', 'LPU-Cavite', 'Permit System'],
        role: 'UI/UX Designer • Front-end Support',
        timeframe: '2024 • Academic project',
        caseStudyUrl: null,
        gallery: [
          'assets/epass/epass_1.png',
          'assets/epass/epass_2.png',
          'assets/epass/epass_3.png',
          'assets/epass/epass_4.png',
          'assets/epass/epass_5.png',
          'assets/epass/epass_6.png',
          'assets/epass/epass_7.png',
          'assets/epass/epass_8.png',
          'assets/epass/epass_9.png',
        ],
        galleryCaptions: {
          0: 'SIA project developed and successfully defended, designed for permit registration and processing at LPU–Cavite.',
          1: 'Features online forms and approval flows for student activity and event permits within the LPU–Cavite system.',
          2: 'Built using HTML5, CSS3, PHP, and MySQL (phpMyAdmin) as the core technologies.',
        },
      ),
      const ProjectCardData(
        title: 'StockUp – Inventory Management System',
        description:
            'An inventory management interface designed to help track stocks, movements, and low-quantity alerts for small businesses and organizations.',
        tags: ['Inventory', 'Bulk Import/Export', 'Web app'],
        role: 'UI/UX Designer',
        timeframe: '2023 • Academic prototype',
        caseStudyUrl: null,
        gallery: [
          'assets/stockup/stockup_1.png',
          'assets/stockup/stockup_2.png',
          'assets/stockup/stockup_3.png',
          'assets/stockup/stockup_4.png',
          'assets/stockup/stockup_5.png',
          'assets/stockup/stockup_6.png',
          'assets/stockup/stockup_7.png',
          'assets/stockup/stockup_8.png',
          'assets/stockup/stockup_9.png',
          'assets/stockup/stockup_10.png',
          'assets/stockup/stockup_11.png',
          'assets/stockup/stockup_12.png',
          'assets/stockup/stockup_13.png',
          'assets/stockup/stockup_14.png',
          'assets/stockup/stockup_15.png',
          'assets/stockup/stockup_16.png',
          'assets/stockup/stockup_17.png',
          'assets/stockup/stockup_18.png',
          'assets/stockup/stockup_19.png',
        ],
        galleryCaptions: {
          0: 'Academic inventory management project accessible only through local hosting, designed for tracking stocks and item movements.',
          1: 'Includes bulk ordering, stock monitoring, and low-quantity alerts for small business use cases.',
          2: 'Developed using HTML5, CSS3, PHP, and MySQL (phpMyAdmin) for managing records and item data.',
        },
      ),
      const ProjectCardData(
        title: 'PawCentral PH: Pet Care Management Platform',
        description:
            'A concept platform for pet owners and clinics with QR-tagged pet profiles, vet visit tracking, and lost-and-found coordination flows.',
        tags: ['Web app', 'Pet Care', 'Prototype'],
        role: 'Product / UI/UX Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: null,
        gallery: [
          'assets/pawcentral/pawcentral_1.png',
          'assets/pawcentral/pawcentral_2.png',
          'assets/pawcentral/pawcentral_3.png',
          'assets/pawcentral/pawcentral_4.png',
          'assets/pawcentral/pawcentral_5.png',
          'assets/pawcentral/pawcentral_6.png',
          'assets/pawcentral/pawcentral_7.png',
          'assets/pawcentral/pawcentral_8.png',
          'assets/pawcentral/pawcentral_9.png',
          'assets/pawcentral/pawcentral_10.png',
          'assets/pawcentral/pawcentral_11.png',
          'assets/pawcentral/pawcentral_12.png',
          'assets/pawcentral/pawcentral_13.png',
          'assets/pawcentral/pawcentral_14.png',
          'assets/pawcentral/pawcentral_15.png',
          'assets/pawcentral/pawcentral_16.png',
        ],
        galleryCaptions: {
          0: 'Prototype designed in Figma as part of a business proposal to streamline pet care services across Cavite.',
          1: 'Concept platform supporting pet registration, adoption workflows, vet appointments, and owner–clinic coordination.',
          2: 'Features QR and microchip tagging, lost-and-found reporting, and centralized pet profile management.',
        },
      ),
      const ProjectCardData(
        title: 'Matharlika',
        description:
            'A concept math learning experience with playful UI, progress tracking, and problem sets for students.',
        tags: ['Mobile app', 'Learning', 'Concept'],
        role: 'Product / UI/UX Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: null,
        gallery: [
          'assets/matharlika/matharlika_1.png',
          'assets/matharlika/matharlika_2.png',
          'assets/matharlika/matharlika_3.png',
          'assets/matharlika/matharlika_4.png',
          'assets/matharlika/matharlika_5.png',
          'assets/matharlika/matharlika_6.png',
          'assets/matharlika/matharlika_7.png',
          'assets/matharlika/matharlika_8.png',
          'assets/matharlika/matharlika_9.png',
          'assets/matharlika/matharlika_10.png',
          'assets/matharlika/matharlika_11.png',
          'assets/matharlika/matharlika_12.png',
          'assets/matharlika/matharlika_13.png',
          'assets/matharlika/matharlika_14.png',
        ],
        galleryCaptions: {
          0: 'Prototype created using Canva, designed as a gamified math learning experience for students.',
          1: 'Features interactive problem-solving activities, a progressing storyline, and engaging UI elements.',
          2: 'Includes leaderboard mechanics and game-type challenges to make mastering mathematical skills more motivating.',
        },
      ),
      const ProjectCardData(
        title: 'PizzaMe',
        description:
            'Food ordering app concept with simple navigation, product cards, and cart flow for small local businesses.',
        tags: ['Mobile app', 'E-commerce', 'Concept'],
        role: 'Product / UI/UX Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: null,
        gallery: [
          'assets/pizzame/pizzame_1.png',
          'assets/pizzame/pizzame_2.png',
          'assets/pizzame/pizzame_3.png',
          'assets/pizzame/pizzame_4.png',
          'assets/pizzame/pizzame_5.png',
          'assets/pizzame/pizzame_6.png',
          'assets/pizzame/pizzame_7.png',
          'assets/pizzame/pizzame_8.png',
          'assets/pizzame/pizzame_9.png',
          'assets/pizzame/pizzame_10.png',
          'assets/pizzame/pizzame_11.png',
        ],
        galleryCaptions: {
          0: 'Prototype created in Canva during 2nd year, exploring a pizza delivery and ordering experience.',
          1: 'Features product browsing, selection, and cart flow designed for small local food businesses.',
          2: 'Concept focuses on simple navigation and a streamlined ordering process for mobile users.',
        },
      ),
      const ProjectCardData(
        title: 'NinjaHands',
        description:
            'A sign language learning app featuring animated video tutorials, gesture-tracking practice, and interactive quizzes to help users learn and reinforce ASL & FSL basics.',
        tags: ['Mobile app', 'UX Flows', 'Concept'],
        role: 'Product / UI/UX Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: null,
        gallery: [
          'assets/ninjahands/1.png',
          'assets/ninjahands/2.png',
          'assets/ninjahands/3.png',
          'assets/ninjahands/4.png',
          'assets/ninjahands/5.png',
          'assets/ninjahands/6.png',
          'assets/ninjahands/7.png',
          'assets/ninjahands/8.png',
          'assets/ninjahands/9.png',
          'assets/ninjahands/10.png',
          'assets/ninjahands/11.png',
          'assets/ninjahands/12.png',
          'assets/ninjahands/13.png',
        ],
        galleryCaptions: {
          0: 'Canva-based prototype originally proposed as a capstone concept for an e-learning sign language platform.',
          1: 'Features animated video lessons, text tutorials, and guided practice flows for learning ASL and FSL basics.',
          2: 'Includes quizzes and progress analytics designed to track user improvement and reinforce learning.',
        },
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
  final List<String> gallery;

  /// key = image index, value = description for that image
  final Map<int, String> galleryCaptions;

  const ProjectCardData({
    required this.title,
    required this.description,
    required this.tags,
    this.role,
    this.timeframe,
    this.caseStudyUrl,
    this.gallery = const [],
    this.galleryCaptions = const {},
  });
}

class _ProjectCardInteractive extends StatelessWidget {
  final ProjectCardData data;
  const _ProjectCardInteractive({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showProjectGalleryDialog(context, data),
      child: ProjectCard(data: data),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectCardData data;
  const ProjectCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Card has NO thumbnail now – text-only on the list.
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

/* ───────────── PROJECT GALLERY DIALOG (CLICK CARD → IMAGES + CAPTION + ZOOM) ───────────── */

void _showProjectGalleryDialog(BuildContext context, ProjectCardData data) {
  if (data.gallery.isEmpty) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: kParchment,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kDeepGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Screenshots coming soon.',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: kText.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      int currentIndex = 0;

      return StatefulBuilder(
        builder: (context, setState) {
          final total = data.gallery.length;
          final caption = data.galleryCaptions[currentIndex];

          return Dialog(
            backgroundColor: kParchment,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780, maxHeight: 620),
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
                            data.title,
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
                    if (data.caseStudyUrl != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => openLink(data.caseStudyUrl!),
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Open Live Site'),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    // Image viewer with caption overlay + click to zoom
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          color: Colors.black.withOpacity(0.05),
                          child: GestureDetector(
                            onTap: () => _showZoomImageDialog(
                              context,
                              data.gallery[currentIndex],
                              caption: caption,
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    data.gallery[currentIndex],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                if (caption != null && caption.isNotEmpty)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.6),
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        caption,
                                        style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          height: 1.4,
                                          color: kParchment,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Pagination + controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currentIndex + 1} of $total',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: kText.withOpacity(0.7),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: currentIndex > 0
                                  ? () {
                                      setState(() {
                                        currentIndex--;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.chevron_left),
                              label: const Text('Previous'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: currentIndex < total - 1
                                  ? () {
                                      setState(() {
                                        currentIndex++;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.chevron_right),
                              label: const Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// Full-screen zoom dialog for project screenshots
void _showZoomImageDialog(
  BuildContext context,
  String assetPath, {
  String? caption,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.black.withOpacity(0.9),
        insetPadding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top bar with close
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Zoom view',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kParchment,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: kParchment),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Center(
                      child: Image.asset(assetPath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              if (caption != null && caption.isNotEmpty) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    caption,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      height: 1.4,
                      color: kParchment.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

/* ───────────────────── EXPERIENCE ───────────────────── */

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

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
        title: 'BS Information Technology',
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
  const _TimelineTile({required this.item});

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
  const _CertificationsSection();

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
        year: '2025',
        details:
            'Participated as part of the ResForce team, collaborating to ideate and design digital solutions for youth- and community-focused challenges.',
        imageAsset: 'assets/certs/unesco_hackathon_delegate.png',
      ),
      _CertificationItem(
        title:
            'NextGenPH: Youth Innovators Reimagining Public Service – Delegate',
        issuer: 'Development Academy of the Philippines',
        year: '2025',
        details:
            'Engaged, together with the ResForce team, in sessions on governance, innovation, and public service, contributing ideas on how technology and design can support civic initiatives.',
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
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 18,
            runSpacing: 18,
            children: certs
                .asMap()
                .entries
                .map(
                  (entry) => SizedBox(
                    width: 360,
                    height: 220, // fixed height for equal-sized cards
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
  final String? imageAsset;

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
            Expanded(
              child: Text(
                item.details,
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  height: 1.6,
                  color: kText.withOpacity(0.9),
                ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
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
                        ? Image.asset(item.imageAsset!, fit: BoxFit.contain)
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

/* ───────────────────── SKILLS – HORIZONTAL + CENTERED SOFT SKILLS ───────────────────── */

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    final designSkills = [
      const _SkillBarData('Figma', 0.9, 'Wireframes • UI kits • Prototypes'),
      const _SkillBarData('Canva', 0.9, 'Pubmats • Posters • Social media'),
      const _SkillBarData(
        'Photoshop (basic)',
        0.6,
        'Simple edits • Layout tweaks',
      ),
    ];

    final devSkills = [
      const _SkillBarData('HTML / CSS', 0.9, 'Semantic, responsive layouts'),
      const _SkillBarData(
        'JavaScript (basic)',
        0.6,
        'Interactions • UI behavior',
      ),
      const _SkillBarData(
        'Flutter / Dart (basic)',
        0.4,
        'UI screens • Simple logic',
      ),
      const _SkillBarData(
        'Git / GitHub',
        0.75,
        'Collaboration • Version control',
      ),
    ];

    final softSkills = [
      'Collaboration',
      'Clear communication',
      'Problem-solving',
      'Attention to detail',
      'Time management',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final softCardWidth = math.min(maxWidth, 520.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(
              label: 'Skills',
              tagline: 'Tools, technologies, and ways I work.',
            ),
            const SizedBox(height: 12),

            // DESIGN & FRONT-END CARD
            ScrollFadeIn(
              delay: const Duration(milliseconds: 60),
              child: HoverCard(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: kParchment,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kSun.withOpacity(0.4)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final isWide = innerConstraints.maxWidth > 680;

                      Widget buildDesignColumn() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Design tools',
                              style: GoogleFonts.nunito(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: kText.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...designSkills.map(
                              (s) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _SkillMeterRow(data: s),
                              ),
                            ),
                          ],
                        );
                      }

                      Widget buildDevColumn() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Front-end & dev basics',
                              style: GoogleFonts.nunito(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: kText.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...devSkills.map(
                              (s) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _SkillMeterRow(data: s),
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _SkillIconBadge(
                                icon: Icons.brush_rounded,
                                color: kLeaf,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Design & Front-end',
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: kDeepGreen,
                                      ),
                                    ),
                                    Text(
                                      'A mix of UI design and implementation.',
                                      style: GoogleFonts.nunito(
                                        fontSize: 11,
                                        color: kText.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          if (isWide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: buildDesignColumn()),
                                const SizedBox(width: 24),
                                Expanded(child: buildDevColumn()),
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDesignColumn(),
                                const SizedBox(height: 8),
                                const Divider(height: 16),
                                const SizedBox(height: 4),
                                buildDevColumn(),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // SOFT SKILLS CARD CENTERED BELOW
            Center(
              child: SizedBox(
                width: softCardWidth,
                child: ScrollFadeIn(
                  delay: const Duration(milliseconds: 120),
                  child: HoverCard(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: kDeepGreen,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kSun.withOpacity(0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _SkillIconBadge(
                                icon: Icons.people_alt_rounded,
                                color: kSun,
                                dark: true,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Soft skills & working style',
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: kParchment,
                                      ),
                                    ),
                                    Text(
                                      'How I work with teams and projects.',
                                      style: GoogleFonts.nunito(
                                        fontSize: 11,
                                        color: kParchment.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: softSkills
                                .map(
                                  (s) => Chip(
                                    label: Text(
                                      s,
                                      style: GoogleFonts.nunito(
                                        fontSize: 11,
                                        color: kParchment,
                                      ),
                                    ),
                                    side: BorderSide(
                                      color: kParchment.withOpacity(0.3),
                                    ),
                                    backgroundColor: kSoftGreen.withOpacity(
                                      0.75,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'I’m comfortable learning new tools quickly as long as the goal is clear and user experience comes first.',
                            style: GoogleFonts.nunito(
                              fontSize: 11,
                              height: 1.6,
                              color: kParchment.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkillIconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool dark;
  const _SkillIconBadge({
    required this.icon,
    required this.color,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: dark ? Colors.black.withOpacity(0.15) : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, size: 18, color: dark ? kSun : color),
    );
  }
}

class _SkillBarData {
  final String label;
  final double level; // 0–1
  final String helper;

  const _SkillBarData(this.label, this.level, this.helper);
}

class _SkillMeterRow extends StatefulWidget {
  final _SkillBarData data;
  const _SkillMeterRow({required this.data});

  @override
  State<_SkillMeterRow> createState() => _SkillMeterRowState();
}

class _SkillMeterRowState extends State<_SkillMeterRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: widget.data.level),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.data.label,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kText,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: _hovering ? 1.0 : 0.0,
                    child: Text(
                      '${(widget.data.level * 100).round()}%',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: kText.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final barWidth = (maxWidth * value).clamp(
                    0.0,
                    maxWidth.toDouble(),
                  );
                  return Container(
                    height: _hovering ? 10 : 8,
                    decoration: BoxDecoration(
                      color: kText.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: barWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [kLeaf, kSun.withOpacity(0.9)],
                        ),
                        boxShadow: _hovering
                            ? [
                                BoxShadow(
                                  color: kSun.withOpacity(0.45),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : [],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 3),
              Text(
                widget.data.helper,
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  color: kText.withOpacity(0.65),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/* ───────────────────── DESIGN GALLERY – SIMPLE CAROUSEL (NO GLOW) ───────────────────── */

class _DesignGallerySection extends StatefulWidget {
  const _DesignGallerySection();

  @override
  State<_DesignGallerySection> createState() => _DesignGallerySectionState();
}

class _DesignGallerySectionState extends State<_DesignGallerySection> {
  late final PageController _pageController;
  late final Timer _autoScrollTimer;
  double _page = 0;

  final List<_DesignShot> _shots = const [
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_1.png',
      label: 'Survey Advertisment Poster',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_2.png',
      label: 'ResForce Handbook Cover',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_3.png',
      label: 'ResForce Competition PPT',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_4.png',
      label: 'Brochure Design',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_5.png',
      label: 'Brochure Design',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_7.png',
      label: 'LPU Research Colloquium PPT',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_8.png',
      label: 'Infographic Visual',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_9.png',
      label: 'Infographic Visual',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_10.png',
      label: 'NSTP Poster',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_11.png',
      label: 'COECSA Pubmat',
    ),
    _DesignShot(
      imageAsset: 'assets/pubmats/pubmat_12.png',
      label: 'Pubmat Design',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // bigger viewportFraction = bigger image in the viewport
    _pageController = PageController(viewportFraction: 0.86);
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? 0;
      });
    });

    // Auto-scroll every 5 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients ||
          !_pageController.position.hasContentDimensions ||
          _shots.length <= 1) {
        return;
      }
      final current = _pageController.page ?? 0;
      final nextPage = (current.round() + 1) % _shots.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _SectionTitle(
          label: 'Design Gallery',
          tagline: 'UI screens, posters, and social visuals.',
          center: true,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 440,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // main carousel (no background glow)
              PageView.builder(
                controller: _pageController,
                itemCount: _shots.length,
                itemBuilder: (context, index) {
                  final distance = (index - _page).abs();
                  final scale = (1 - distance * 0.12).clamp(0.9, 1.0);
                  final opacity = (1 - distance * 0.4).clamp(0.45, 1.0);

                  return Center(
                    child: Opacity(
                      opacity: opacity,
                      child: _DesignShotImage(
                        shot: _shots[index],
                        baseScale: scale,
                        onTap: () =>
                            _showDesignZoomDialog(context, _shots[index]),
                      ),
                    ),
                  );
                },
              ),

              // previous button
              Positioned(
                left: 12,
                child: _GalleryArrowButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () {
                    if (!_pageController.hasClients) return;
                    final current = _pageController.page ?? 0;
                    final prevPage =
                        (current.round() - 1 + _shots.length) % _shots.length;
                    _pageController.animateToPage(
                      prevPage,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),

              // next button
              Positioned(
                right: 12,
                child: _GalleryArrowButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: () {
                    if (!_pageController.hasClients) return;
                    final current = _pageController.page ?? 0;
                    final nextPage = (current.round() + 1) % _shots.length;
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_shots.length, (i) {
            final isActive = (_page.round() == i);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isActive ? 22 : 8,
              decoration: BoxDecoration(
                color: isActive ? kSun : kParchment.withOpacity(0.45),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _GalleryArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GalleryArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 22, color: kParchment),
        ),
      ),
    );
  }
}

class _DesignShot {
  final String imageAsset;
  final String? label;

  const _DesignShot({required this.imageAsset, this.label});
}

class _DesignShotImage extends StatefulWidget {
  final _DesignShot shot;
  final double baseScale;
  final VoidCallback? onTap;

  const _DesignShotImage({
    required this.shot,
    this.baseScale = 1.0,
    this.onTap,
  });

  @override
  State<_DesignShotImage> createState() => _DesignShotImageState();
}

class _DesignShotImageState extends State<_DesignShotImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final targetScale = widget.baseScale * (_hovering ? 1.06 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: targetScale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.shot.imageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (widget.shot.label != null)
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.photo_library_rounded,
                              size: 13,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.shot.label!,
                              style: GoogleFonts.nunito(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen zoom dialog for gallery designs
void _showDesignZoomDialog(BuildContext context, _DesignShot shot) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.black.withOpacity(0.96),
        insetPadding: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      shot.label ?? 'Design preview',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kParchment,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: kParchment),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    child: Center(
                      child: Image.asset(shot.imageAsset, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/* ───────────────────── CONTACT ───────────────────── */

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Contact',
          tagline: 'Let’s collaborate on thoughtful interfaces.',
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kSoftGreen, kDeepGreen],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: kSun.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 720;
              return Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isWide ? 3 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I’m currently open to UI/UX internship roles (on-site and hybrid only).',
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            height: 1.7,
                            color: kParchment,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'If you are interested in offering me an internship opportunity, please email me. I am required to complete 500 hours of on-the-job training and will be available to start in February 2025.',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            height: 1.7,
                            color: kParchment.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                sendEmail(
                                  'paradero.marianne15@gmail.com',
                                  subject: 'UI/UX Internship Inquiry',
                                );
                              },
                              icon: const Icon(Icons.mail_rounded, size: 18),
                              label: const Text('Email me'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                openLink(kGithubProfileUrl);
                              },
                              icon: const Icon(Icons.link_rounded, size: 18),
                              label: const Text('View Github profile'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isWide)
                    const SizedBox(width: 24)
                  else
                    const SizedBox(height: 18),
                  Expanded(
                    flex: isWide ? 2 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ContactMethodCard(
                          icon: Icons.email_rounded,
                          label: 'Email',
                          value: 'paradero.marianne15@gmail.com',
                          onTap: () {
                            sendEmail(
                              'paradero.marianne15@gmail.com',
                              subject: 'UI/UX Internship Inquiry',
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        _ContactMethodCard(
                          icon: Icons.web_rounded,
                          label: 'Github',
                          value: 'https://github.com/rhaleighp15',
                          onTap: () =>
                              openLink('https://github.com/rhaleighp15'),
                        ),
                        const SizedBox(height: 8),
                        const _ContactMethodCard(
                          icon: Icons.location_on_rounded,
                          label: 'Location',
                          value: 'Cavite, Philippines',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Text(
            '© $year Marianne Rhaleigh G. Paradero • UI/UX & Front-end',
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

class _ContactMethodCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactMethodCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: kDeepGreen.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kSun.withOpacity(0.35)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kLeaf.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Icon(icon, size: 18, color: kSun),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          color: kParchment.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 2),
                      SelectableText(
                        value,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kParchment,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

/* ───────────────────── LINK HELPERS ───────────────────── */

Future<void> openLink(String url) async {
  Uri uri;

  // For web, resolve asset-like paths to full URL; for normal links, just parse
  if (kIsWeb && (url.startsWith('assets/') || url.startsWith('/assets/'))) {
    uri = Uri.base.resolve(url);
  } else {
    uri = Uri.parse(url);
  }

  final ok = await launchUrl(
    uri,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: kIsWeb ? '_blank' : null,
  );
  if (!ok) {
    debugPrint('Could not launch $uri');
  }
}

Future<void> sendEmail(String email, {String? subject, String? body}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      if (subject != null && subject.isNotEmpty) 'subject': subject,
      if (body != null && body.isNotEmpty) 'body': body,
    },
  );

  final ok = await launchUrl(uri);
  if (!ok) {
    debugPrint('Could not launch email client for $email');
  }
}

/// Download the CV as an asset (web: forces download via hidden <a>, others: fallback open)
Future<void> downloadCvAsset() async {
  const assetPath = 'assets/cv/paradero_cv.pdf';

  if (kIsWeb) {
    // Resolve to full URL (handles /#/ routes etc.)
    final url = Uri.base.resolve(assetPath).toString();

    final anchor = html.AnchorElement(href: url)
      ..download = 'Marianne_Rhaleigh_Paradero_CV.pdf'
      ..target = '_blank';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  } else {
    // If you ever build for mobile/desktop, this will open the PDF
    final uri = Uri.parse(assetPath);
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!ok) {
      debugPrint('Could not launch $uri');
    }
  }
}
