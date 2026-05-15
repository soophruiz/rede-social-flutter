import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../design_system/colors.dart';
import '../design_system/typography.dart';
import '../design_system/spacing.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;

  const ProfilePage({this.userId, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final state = Provider.of<AppState>(context, listen: false);
    final user = widget.userId == null
        ? state.currentUser
        : state.getUserById(widget.userId!);
    _nameController = TextEditingController(text: user?.name ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final viewedUser = widget.userId == null
        ? state.currentUser
        : state.getUserById(widget.userId!);

    if (viewedUser == null) {
      return Center(
        child: Text(
          'Usuário não encontrado.',
          style: AppTypography.bodyLg,
        ),
      );
    }

    final currentUser = state.currentUser;
    final isOwnProfile = currentUser != null && currentUser.id == viewedUser.id;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final followers = state.followersCount(viewedUser.id);
    final following = state.followingCount(viewedUser.id);
    final followingStatus = currentUser != null && state.isFollowing(viewedUser.id);

    final profilePosts = state.posts
        .where((post) => post.userId == viewedUser.id)
        .toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          elevation: 0,
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.bgLight,
          title: Text(
            isOwnProfile ? 'Perfil' : 'Perfil de ${viewedUser.name}',
            style: AppTypography.headingLg.copyWith(
              color: isDark ? Colors.white : AppColors.textLight,
            ),
          ),
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.lg),
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(13),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, -50),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: viewedUser.avatarUrl != null && viewedUser.avatarUrl!.isNotEmpty
                                    ? NetworkImage(viewedUser.avatarUrl!)
                                    : null,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text('@${viewedUser.name}'),
                            const SizedBox(height: AppSpacing.xs),
                            Text('@${viewedUser.name}',
                                style: AppTypography.bodySm.copyWith(
                                  color: AppColors.textLightSecondary,
                                )),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              viewedUser.bio ?? '',
                              style: AppTypography.bodyMd.copyWith(
                                color: AppColors.textLightSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStat('Seguidores', followers),
                                const SizedBox(width: AppSpacing.lg),
                                _buildStat('Seguindo', following),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            if (!isOwnProfile && currentUser != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => state.toggleFollow(viewedUser.id),
                                    child: Text(followingStatus ? 'Seguindo' : 'Seguir'),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Mensagem'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                if (isOwnProfile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Editar perfil', style: AppTypography.headingMd),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _nameController,
                        style: AppTypography.bodyMd,
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _bioController,
                        maxLines: 3,
                        style: AppTypography.bodyMd,
                        decoration: InputDecoration(
                          labelText: 'Bio / Descrição',
                          prefixIcon: const Icon(Icons.info_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            state.updateProfile(
                              name: _nameController.text.trim(),
                              bio: _bioController.text.trim(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Perfil atualizado com sucesso! ✨'),
                                backgroundColor: AppColors.success,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Salvar Alterações'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            state.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (_) => false,
                            );
                          },
                          icon: const Icon(Icons.logout_outlined),
                          label: const Text('Sair'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publicações de ${viewedUser.name}', style: AppTypography.headingMd),
                      const SizedBox(height: AppSpacing.lg),
                      ...profilePosts.map((post) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.lg),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post.content, style: AppTypography.bodyMd),
                                if (post.imageUrl != null) ...[
                                  const SizedBox(height: AppSpacing.md),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(AppSpacing.md),
                                    child: Image.network(post.imageUrl!, fit: BoxFit.cover),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                      if (profilePosts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                          child: Text(
                            'Nenhuma publicação ainda.',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.textLightSecondary),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(value.toString(), style: AppTypography.headingMd.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.bodySm.copyWith(color: AppColors.textLightSecondary)),
      ],
    );
  }
}
