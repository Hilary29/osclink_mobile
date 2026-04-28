import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_colors.dart';
import 'package:osclink_mobile/2_home/presentation/widgets/post_card_widget.dart';
import '../../business_logic/profile_bloc.dart';
import '../../business_logic/profile_event.dart';
import '../../business_logic/profile_state.dart';
import '../../data/models/profile_model.dart';
import '../widgets/profile_stats_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state is ProfileError) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message,
                      style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            ),
          );
        }

        if (state is ProfileLoaded) {
          return _ProfileView(profile: state.profile);
        }

        return const SizedBox();
      },
    );
  }
}

class _ProfileView extends StatelessWidget {
  final UserProfile profile;

  const _ProfileView({required this.profile});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _CoverSliverAppBar(profile: profile),
            SliverToBoxAdapter(
              child: _ProfileInfoSection(profile: profile),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabBarDelegate(
                TabBar(
                  tabs: const [
                    Tab(text: 'Publications'),
                    Tab(text: 'À propos'),
                    Tab(text: 'Projets'),
                  ],
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 2,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _PostsTab(profile: profile),
              _AboutTab(profile: profile),
              _ProjectsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverSliverAppBar extends StatelessWidget {
  final UserProfile profile;

  const _CoverSliverAppBar({required this.profile});

  static const double _coverHeight = 160;
  static const double _avatarRadius = 44;
  // expandedHeight = cover + avatar bottom half + breathing room
  static const double _expandedHeight = _coverHeight  + 18;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _expandedHeight,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _coverHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  profile.coverUrl != null
                      ? Image.network(
                          profile.coverUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _CoverFallback(),
                        )
                      : _CoverFallback(),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x55000000), Colors.transparent],
                        stops: [0.0, 0.6],
                      ),
                    ),
                  ),
                  // Bouton Edit en bas à droite de la cover
                  Positioned(
                    bottom: 0,
                    right: 16,
                    child: IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ProfileBloc>(),
                            child: ProfileEditScreen(profile: profile),
                          ),
                          
                        ),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white70),
                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ), icon: Icon(Icons.edit_square,
                          color: AppColors.primary, size: 22),
                    ),
                  ),
                ],
              ),
            ),
            // Fond blanc sous la cover (zone de chevauchement de l'avatar)
            Positioned(
              top: _coverHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(color: Colors.white),
            ),
            // Avatar centré sur la frontière cover/blanc — toujours au-dessus
            Positioned(
              top: _coverHeight - _avatarRadius,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: CircleAvatar(
                  radius: _avatarRadius,
                  backgroundImage: NetworkImage(profile.avatarUrl),
                  backgroundColor: const Color(0xFFCED5DC),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, Color(0xFF025C47)],
        ),
      ),
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  final UserProfile profile;

  const _ProfileInfoSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NameRow(profile: profile),
          const SizedBox(height: 2),
          Text(
            profile.username,
            style:
                const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 10),
          Text(
            profile.bio,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF141619),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _MetaRow(profile: profile),
          const SizedBox(height: 16),
          ProfileStatsRow(
            postsCount: profile.postsCount,
            followersCount: profile.followersCount,
            followingCount: profile.followingCount,
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _NameRow extends StatelessWidget {
  final UserProfile profile;

  const _NameRow({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            profile.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF141619),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (profile.isVerified) ...[
          const SizedBox(width: 6),
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF4C9EEB),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.white),
          ),
        ],
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final UserProfile profile;

  const _MetaRow({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: [
        if (profile.location != null)
          _MetaChip(icon: Icons.location_on_outlined, text: profile.location!),
        if (profile.website != null)
          _MetaChip(
              icon: Icons.link,
              text: profile.website!,
              color: AppColors.primary),
        _MetaChip(
          icon: Icons.calendar_today_outlined,
          text:
              'Depuis ${_monthName(profile.joinedAt.month)} ${profile.joinedAt.year}',
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'janv.',
      'févr.',
      'mars',
      'avr.',
      'mai',
      'juin',
      'juil.',
      'août',
      'sept.',
      'oct.',
      'nov.',
      'déc.'
    ];
    return months[month];
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.text,
    this.color = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 13, color: color)),
      ],
    );
  }
}

// ─── Sticky TabBar Delegate ───────────────────

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => false;
}

// ─── Tab: Publications ────────────────────────

class _PostsTab extends StatelessWidget {
  final UserProfile profile;

  const _PostsTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.posts.isEmpty) {
      return const Center(
        child: Text('Aucune publication',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: profile.posts.length,
      itemBuilder: (_, index) => PostCardWidget(post: profile.posts[index]),
    );
  }
}

// ─── Tab: À propos ────────────────────────────

class _AboutTab extends StatelessWidget {
  final UserProfile profile;

  const _AboutTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AboutCard(
            icon: Icons.business_outlined,
            title: 'Type d\'organisation',
            value: profile.organizationType,
          ),
          const SizedBox(height: 12),
          if (profile.location != null)
            _AboutCard(
              icon: Icons.location_on_outlined,
              title: 'Localisation',
              value: profile.location!,
            ),
          if (profile.location != null) const SizedBox(height: 12),
          if (profile.website != null)
            _AboutCard(
              icon: Icons.link,
              title: 'Site web',
              value: profile.website!,
              valueColor: AppColors.primary,
            ),
          if (profile.website != null) const SizedBox(height: 12),
          _AboutCard(
            icon: Icons.calendar_today_outlined,
            title: 'Membre depuis',
            value:
                '${_monthName(profile.joinedAt.month)} ${profile.joinedAt.year}',
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return months[month];
  }
}

class _AboutCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color valueColor;

  const _AboutCard({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor = const Color(0xFF141619),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCED5DC), width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: valueColor,
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

// ─── Tab: Projets ─────────────────────────────

class _ProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) => _ProjectCard(index: index),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final int index;

  const _ProjectCard({required this.index});

  static const _projects = [
    (
      title: 'Renforcement des capacités des OSC',
      status: 'En cours',
      desc:
          'Formation et accompagnement des organisations de la société civile locale.'
    ),
    (
      title: 'Observatoire citoyen numérique',
      status: 'Planifié',
      desc: 'Plateforme de suivi participatif des politiques publiques.'
    ),
    (
      title: 'Dialogue politique inclusif',
      status: 'Terminé',
      desc: 'Facilitation de dialogues entre OSC et décideurs publics.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final p = _projects[index];
    final isActive = p.status == 'En cours';
    final isDone = p.status == 'Terminé';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCED5DC), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  p.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF141619),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : isDone
                          ? const Color(0xFFEEEEEE)
                          : AppColors.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  p.status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? AppColors.primary
                        : isDone
                            ? AppColors.textSecondary
                            : AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            p.desc,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileEditScreen extends StatefulWidget {
  final UserProfile profile;

  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _websiteCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.profile.name);
    _bioCtrl = TextEditingController(text: widget.profile.bio);
    _locationCtrl = TextEditingController(text: widget.profile.location ?? '');
    _websiteCtrl = TextEditingController(text: widget.profile.website ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    _locationCtrl.dispose();
    _websiteCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    context.read<ProfileBloc>().add(
          UpdateProfileEvent(
            name: _nameCtrl.text.trim(),
            bio: _bioCtrl.text.trim(),
            location: _locationCtrl.text.trim().isEmpty
                ? null
                : _locationCtrl.text.trim(),
            website: _websiteCtrl.text.trim().isEmpty
                ? null
                : _websiteCtrl.text.trim(),
          ),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.primary),
                    )
                  : const Text(
                      'Enregistrer',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Avatar preview
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: NetworkImage(widget.profile.avatarUrl),
                    backgroundColor: const Color(0xFFCED5DC),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _EditField(
              label: 'Nom',
              controller: _nameCtrl,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 12),
            _EditField(
              label: 'Bio',
              controller: _bioCtrl,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            _EditField(
              label: 'Localisation',
              controller: _locationCtrl,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),
            _EditField(
              label: 'Site web',
              controller: _websiteCtrl,
              prefixIcon: Icons.link,
              keyboardType: TextInputType.url,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _EditField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: AppColors.textSecondary)
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFCED5DC)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFCED5DC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}


class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionLabel('Compte'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsTile(
                icon: Icons.email_outlined,
                title: 'Adresse e-mail',
                subtitle: 'keubouhilary@gmail.com',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: 'Mot de passe',
                subtitle: 'Modifier le mot de passe',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Confidentialité',
                subtitle: 'Gérer la visibilité du profil',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionLabel('Notifications'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _ToggleTile(
                icon: Icons.notifications_outlined,
                title: 'Nouvelles publications',
                initialValue: true,
              ),
              _ToggleTile(
                icon: Icons.chat_bubble_outline,
                title: 'Messages',
                initialValue: true,
              ),
              _ToggleTile(
                icon: Icons.group_outlined,
                title: 'Abonnements',
                initialValue: false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionLabel('Assistance'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsTile(
                icon: Icons.help_outline,
                title: 'Centre d\'aide',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'À propos d\'OSC Link',
                subtitle: 'Version 1.0.0',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SettingsCard(
            items: [
              _SettingsTile(
                icon: Icons.logout,
                title: 'Déconnexion',
                titleColor: Colors.red,
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> items;

  const _SettingsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCED5DC), width: 0.5),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          return Column(
            children: [
              items[i],
              if (i < items.length - 1)
                const Divider(
                  height: 1,
                  color: Color(0xFFCED5DC),
                  indent: 52,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color titleColor;
  final Color iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.titleColor = const Color(0xFF141619),
    this.iconColor = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: titleColor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textSecondary))
          : null,
      trailing:
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFFBDC5CD)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

class _ToggleTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool initialValue;

  const _ToggleTile({
    required this.icon,
    required this.title,
    required this.initialValue,
  });

  @override
  State<_ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<_ToggleTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, size: 20, color: AppColors.textSecondary),
      title: Text(
        widget.title,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF141619)),
      ),
      trailing: Switch(
        value: _value,
        onChanged: (v) => setState(() => _value = v),
        activeColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}
