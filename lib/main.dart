import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* ───────────────────── PALETTE – HOWL BEDROOM VIBE ───────────────────── */

const Color kBg = Color(0xFF18190C);        // deep olive background
const Color kText = Color(0xFF24160B);      // warm ink brown
const Color kDeepGreen = Color(0xFF273417); // shadowy moss
const Color kLeaf = Color(0xFF6B8F3A);      // bright mossy green
const Color kSoftGreen = Color(0xFF3B4F22); // muted mid-green
const Color kSun = Color(0xFFCFAF5B);       // antique gold
const Color kParchment = Color(0xFFF3E4C6); // parchment surface
const Color kTeal = Color(0xFF2D7A6A);      // bottle teal
const Color kRose = Color(0xFFB4575E);      // dusty ruby

void main() {
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
          bodyColor: kText,
          displayColor: kText,
        ),
        colorScheme: ColorScheme.dark(
          primary: kLeaf,
          secondary: kSun,
          surface: kParchment,
          background: kBg,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLeaf,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            elevation: 6,
            shadowColor: kLeaf.withOpacity(0.6),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kParchment,
            side: BorderSide(color: kParchment.withOpacity(0.9)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          return SingleChildScrollView(
            child: Column(
              children: [
                _TopNav(isWide: isWide),
                _HeroSection(isWide: isWide),
                const SizedBox(height: 40),
                _SectionWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _AboutSection(),
                      SizedBox(height: 40),
                      _ProjectsSection(),
                      SizedBox(height: 40),
                      _ExperienceSection(),
                      SizedBox(height: 40),
                      _SkillsSection(),
                      SizedBox(height: 40),
                      _ContactSection(),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/* ───────────────────── TOP NAV – TAPED PANEL ───────────────────── */

class _TopNav extends StatelessWidget {
  final bool isWide;
  const _TopNav({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SizedBox(
            height: 80,
            child: Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 40,
                  child: _TapePiece(
                    width: 80,
                    height: 16,
                    rotation: -0.07,
                  ),
                ),
                const Positioned(
                  top: 4,
                  right: 60,
                  child: _TapePiece(
                    width: 68,
                    height: 16,
                    rotation: 0.05,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: kParchment.withOpacity(0.96),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: kSun.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.45),
                          blurRadius: 28,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: kSoftGreen,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: kSun.withOpacity(0.7),
                                  width: 1.2,
                                ),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                size: 20,
                                color: kSun,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Name',
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: kDeepGreen,
                                  ),
                                ),
                                Text(
                                  'UI/UX • Visual storyteller',
                                  style: GoogleFonts.nunito(
                                    fontSize: 11,
                                    color: kDeepGreen.withOpacity(0.7),
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
                              _NavItem(label: 'Skills'),
                              _NavItem(label: 'Contact'),
                            ],
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
    );
  }
}

class _TapePiece extends StatelessWidget {
  final double width;
  final double height;
  final double rotation;

  const _TapePiece({
    required this.width,
    required this.height,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kRose.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
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
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _hovering ? kSoftGreen.withOpacity(0.9) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: _hovering ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: const Icon(
                Icons.star,
                size: 14,
                color: kSun,
              ),
            ),
            if (_hovering) const SizedBox(width: 4),
            Text(
              widget.label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                color:
                    _hovering ? kParchment : kDeepGreen.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── HERO WITH FLOATING CHARMS ───────────────────── */

class _HeroSection extends StatefulWidget {
  final bool isWide;
  const _HeroSection({required this.isWide});

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _floatAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedBuilder(
            animation: _floatAnim,
            builder: (context, _) {
              final floatValue = _floatAnim.value;
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 24),
                      child: child,
                    ),
                  );
                },
                child: _HeroContent(
                  isWide: widget.isWide,
                  floatValue: floatValue,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool isWide;
  final double floatValue;
  const _HeroContent({
    required this.isWide,
    required this.floatValue,
  });

  @override
  Widget build(BuildContext context) {
    final left = Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'UI / UX DESIGNER',
          style: GoogleFonts.nunito(
            fontSize: 13,
            letterSpacing: 5,
            fontWeight: FontWeight.w700,
            color: kSun,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Portfolio',
          style: GoogleFonts.cormorantGaramond(
            fontSize: isWide ? 64 : 46,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
            color: kParchment,
            shadows: [
              Shadow(
                blurRadius: 18,
                color: kSun.withOpacity(0.9),
                offset: const Offset(0, 6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Interfaces that feel like a magical bedroom full of trinkets — cozy, cluttered in the right way,\n'
          'but still clear, usable, and calm. I love building flows that quietly guide people through complex tasks.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 14,
            height: 1.8,
            color: kParchment.withOpacity(0.88),
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // TODO: scroll to projects section
              },
              icon: const Icon(Icons.grid_view_rounded),
              label: const Text('View case studies'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: open CV link
              },
              icon: const Icon(Icons.description),
              label: const Text('Download CV'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _HeroTag(label: 'Product thinking'),
            _HeroTag(label: 'Interaction design'),
            _HeroTag(label: 'Design systems'),
          ],
        ),
      ],
    );

    final right = _HeroIllustrationCard(isWide: isWide);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E2210),
            Color(0xFF303B1C),
            Color(0xFF2B3530),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 50,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Stack(
        children: [
          // floating charms / trinkets
          _FloatingCharm(
            top: 10,
            left: 40,
            progress: floatValue,
            travel: 10,
            phase: 0.0,
            icon: Icons.star,
            size: 16,
            color: kSun,
          ),
          _FloatingCharm(
            top: 40,
            right: 80,
            progress: floatValue,
            travel: 8,
            phase: 0.35,
            icon: Icons.circle,
            size: 10,
            color: kTeal,
          ),
          _FloatingCharm(
            bottom: 24,
            left: 80,
            progress: floatValue,
            travel: 12,
            phase: 0.6,
            icon: Icons.diamond,
            size: 18,
            color: kRose,
          ),
          _FloatingCharm(
            top: 90,
            right: 32,
            progress: floatValue,
            travel: 9,
            phase: 0.9,
            icon: Icons.circle,
            size: 12,
            color: kLeaf,
          ),
          isWide
              ? Row(
                  children: [
                    Expanded(child: left),
                    const SizedBox(width: 32),
                    Expanded(child: right),
                  ],
                )
              : Column(
                  children: [
                    right,
                    const SizedBox(height: 24),
                    left,
                  ],
                ),
        ],
      ),
    );
  }
}

class _FloatingCharm extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double progress;
  final double travel;
  final double phase;
  final IconData icon;
  final double size;
  final Color color;

  const _FloatingCharm({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.progress,
    required this.travel,
    required this.phase,
    required this.icon,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double angle = (progress + phase) * 2 * math.pi;
    final double dy = math.sin(angle) * travel;
    final double opacity =
        0.4 + 0.5 * (math.sin(angle) * 0.5 + 0.5); // soft shimmer

    return Positioned(
      top: top != null ? top! + dy : null,
      left: left,
      right: right,
      bottom: bottom != null ? bottom! - dy : null,
      child: Opacity(
        opacity: opacity,
        child: Icon(
          icon,
          size: size,
          color: color.withOpacity(0.95),
        ),
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

class _HeroIllustrationCard extends StatelessWidget {
  final bool isWide;
  const _HeroIllustrationCard({required this.isWide});

  @override
  Widget build(BuildContext context) {
    final aspect = isWide ? 4 / 3 : 16 / 11;

    return AspectRatio(
      aspectRatio: aspect,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A3019),
                  Color(0xFF40311C),
                  Color(0xFF283438),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: kParchment.withOpacity(0.96),
                ),
                child: Stack(
                  children: [
                    // headboard-ish hill of green
                    Positioned(
                      bottom: -40,
                      left: -20,
                      right: -20,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          gradient: const LinearGradient(
                            colors: [kDeepGreen, kLeaf],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // warm glowing orb
                    Positioned(
                      top: 24,
                      left: 26,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: kSun,
                          borderRadius: BorderRadius.circular(56),
                          boxShadow: [
                            BoxShadow(
                              color: kSun.withOpacity(0.7),
                              blurRadius: 22,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // hanging small dots
                    const _SpiritDot(top: 40, right: 40),
                    const _SpiritDot(top: 80, right: 80),
                    const _SpiritDot(bottom: 60, left: 80),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 42,
                            backgroundColor: kBg,
                            child: Icon(
                              Icons.person,
                              size: 44,
                              color: kParchment,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Place your illustration here',
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              color: kDeepGreen.withOpacity(0.85),
                            ),
                          ),
                          Text(
                            'Howl-inspired bedroom / avatar',
                            style: GoogleFonts.nunito(
                              fontSize: 11,
                              color: kDeepGreen.withOpacity(0.65),
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
        ],
      ),
    );
  }
}

class _SpiritDot extends StatelessWidget {
  final double? top, left, right, bottom;
  const _SpiritDot({this.top, this.left, this.right, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: kSun.withOpacity(0.9),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: kSun.withOpacity(0.7),
              blurRadius: 14,
              spreadRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────── SECTION WRAPPER ───────────────────── */

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

/* ───────────────────── TITLES ───────────────────── */

class _SectionTitle extends StatelessWidget {
  final String label;
  final String tagline;
  const _SectionTitle({required this.label, required this.tagline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.nunito(
            fontSize: 13,
            letterSpacing: 3,
            color: kParchment.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          tagline,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: kParchment,
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'About',
          tagline: 'Designing cozy, magical experiences.',
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: kParchment,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kSun.withOpacity(0.4)),
          ),
          child: Text(
            'I’m a student UI/UX designer who enjoys turning messy ideas into clear, story-driven interfaces.\n'
            'My work pulls from animation, cluttered shelves, and soft lighting — but always stays grounded in\n'
            'usability and calm flows. I’m looking for an internship where I can support product teams with\n'
            'wireframes, prototypes, and design systems while learning from kind mentors.',
            style: GoogleFonts.nunito(
              fontSize: 13,
              height: 1.7,
              color: kText,
            ),
          ),
        ),
      ],
    );
  }
}

/* ───────────────────── PROJECT DETAIL DIALOG ───────────────────── */

void _showProjectDialog(BuildContext context, ProjectCardData data) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: kParchment,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            label: Text(t, style: const TextStyle(fontSize: 11)),
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
                        // TODO: Use url_launcher to open data.caseStudyUrl
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

/* ───────────────────── PROJECTS ───────────────────── */

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final projects = [
      const ProjectCardData(
        title: 'EduConnect – E-learning platform',
        description:
            'Responsive web app for senior high school students: dashboards, tasks, quizzes, and simple analytics.',
        tags: ['Web app', 'Dashboard', 'Education'],
        role: 'Product / UI / UX Designer',
        timeframe: '2024 • Capstone concept',
        caseStudyUrl: 'https://your-link-here.com/educonnect',
      ),
      const ProjectCardData(
        title: 'PawCentral PH – Pet care app',
        description:
            'Concept mobile app for pet owners with QR-tag profiles, vet appointments, and lost-and-found flows.',
        tags: ['Mobile app', 'UX flows', 'Concept'],
        role: 'UX / UI Designer',
        timeframe: '2024 • Personal project',
        caseStudyUrl: 'https://your-link-here.com/pawcentral',
      ),
      const ProjectCardData(
        title: 'UI Exploration Library',
        description:
            'A playground of empty states, onboarding, and component variations in a unified visual system.',
        tags: ['Design system', 'Figma', 'Components'],
        role: 'Visual / Systems Design',
        timeframe: 'Ongoing • Study project',
        caseStudyUrl: 'https://your-link-here.com/ui-library',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Projects',
          tagline: 'Case studies & key work.',
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (entry) => SizedBox(
                      width: isWide
                          ? (constraints.maxWidth - 36) / 3
                          : constraints.maxWidth,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration:
                            Duration(milliseconds: 500 + entry.key * 120),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 18),
                              child: child,
                            ),
                          );
                        },
                        child: HoverCard(
                          child: _ProjectCardInteractive(data: entry.value),
                        ),
                      ),
                    ),
                  )
                  .toList(),
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

  const ProjectCardData({
    required this.title,
    required this.description,
    required this.tags,
    this.role,
    this.timeframe,
    this.caseStudyUrl,
  });
}

class _ProjectCardInteractive extends StatelessWidget {
  final ProjectCardData data;
  const _ProjectCardInteractive({required this.data});

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
  const ProjectCard({required this.data});

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

/* ───────────────────── EXPERIENCE ───────────────────── */

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

  @override
  Widget build(BuildContext context) {
    final items = [
      _TimelineItem(
        title: 'BS Information Technology (Student)',
        subtitle: 'Your University • 2023 – Present',
        details:
            'Capstone projects in e-learning and product platforms; focus on UI/UX, web dev, and research.',
      ),
      _TimelineItem(
        title: 'Freelance / Personal UI projects',
        subtitle: '2024',
        details:
            'Designed landing pages and app concepts with strong hierarchy, motion, and color stories.',
      ),
      _TimelineItem(
        title: 'Student organization designer',
        subtitle: '2022 – 2023',
        details:
            'Created event posters, social media graphics, and simple sites for campus events.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Experience',
          tagline: 'Education & involvement.',
        ),
        Column(
          children: items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _TimelineTile(item: item),
                ),
              )
              .toList(),
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

/* ───────────────────── SKILLS ───────────────────── */

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    final designTools = ['Figma', 'Adobe XD', 'Photoshop', 'Illustrator'];
    final devTools = ['Flutter', 'HTML/CSS', 'Basic JS', 'Git'];
    final softSkills = [
      'Collaboration',
      'Problem-solving',
      'Communication',
      'Attention to detail',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Skills',
          tagline: 'What I bring to a team.',
        ),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            _SkillGroup(title: 'Design tools', items: designTools),
            _SkillGroup(title: 'Development', items: devTools),
            _SkillGroup(title: 'Soft skills', items: softSkills),
          ],
        ),
      ],
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const _SkillGroup({required this.title, required this.items});

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

/* ───────────────────── CONTACT ───────────────────── */

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          label: 'Contact',
          tagline: 'Let’s work together.',
        ),
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
            '© ${DateTime.now().year} Your Name • UI/UX & Illustration',
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
  const _ContactChip({required this.icon, required this.label});

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
          transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}
