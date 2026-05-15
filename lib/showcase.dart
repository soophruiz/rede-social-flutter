// Thomas e Sophia DEVB
// Design System Components Showcase
// Exemplos de uso de todos os componentes do Design System

import 'package:flutter/material.dart';
import 'src/components/custom_text_input.dart';
import 'src/components/glass_card.dart';
import 'src/components/post_card.dart';
import 'src/components/primary_button.dart';
import 'src/components/user_avatar.dart';
import 'src/design_system/colors.dart';
import 'src/design_system/spacing.dart';

class DesignSystemShowcase extends StatefulWidget {
  const DesignSystemShowcase({super.key});

  @override
  State<DesignSystemShowcase> createState() => _DesignSystemShowcaseState();
}

class _DesignSystemShowcaseState extends State<DesignSystemShowcase> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isLoadingButton = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SeÃ§Ã£o de Buttons
            Text(
              'BotÃµes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'BotÃ£o PrimÃ¡rio',
              onPressed: () {
                setState(() => _isLoadingButton = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    setState(() => _isLoadingButton = false);
                  }
                });
              },
              isLoading: _isLoadingButton,
              icon: Icons.check,
            ),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Material Elevated Button'),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Material Outlined Button'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () {},
              child: const Text('Material Text Button'),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // SeÃ§Ã£o de Inputs
            Text(
              'Campos de Entrada',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextInput(
              label: 'E-mail',
              hintText: 'seu@email.com',
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => 
                value?.isEmpty ?? true ? 'E-mail obrigatÃ³rio' : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomTextInput(
              label: 'Senha',
              hintText: 'Digite sua senha',
              prefixIcon: Icons.lock_outlined,
              controller: _passwordController,
              obscureText: true,
              validator: (value) => 
                value?.isEmpty ?? true ? 'Senha obrigatÃ³ria' : null,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // SeÃ§Ã£o de Glass Card
            Text(
              'Glass Card (Glassmorphism)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card com Efeito de Vidro',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Este Ã© um card com efeito glassmorphism, usando BackdropFilter para criar um visual de vidro fosco moderno.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // SeÃ§Ã£o de Avatars
            Text(
              'Avatares de UsuÃ¡rio',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: AppSpacing.lg,
                children: [
                  Column(
                    children: [
                      UserAvatar(
                        imageUrl: 'https://ui-avatars.com/api/?name=JoÃ£o+Silva&background=6C63FF&color=ffffff',
                        initials: 'JS',
                        size: AvatarSize.xs,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('XS'),
                    ],
                  ),
                  Column(
                    children: [
                      UserAvatar(
                        imageUrl: 'https://ui-avatars.com/api/?name=Maria+Santos&background=2563EB&color=ffffff',
                        initials: 'MS',
                        size: AvatarSize.sm,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('SM'),
                    ],
                  ),
                  Column(
                    children: [
                      UserAvatar(
                        imageUrl: 'https://ui-avatars.com/api/?name=Pedro+Costa&background=10B981&color=ffffff',
                        initials: 'PC',
                        size: AvatarSize.md,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('MD'),
                    ],
                  ),
                  Column(
                    children: [
                      UserAvatar(
                        imageUrl: 'https://ui-avatars.com/api/?name=Ana+Lima&background=FB923C&color=ffffff',
                        initials: 'AL',
                        size: AvatarSize.lg,
                        isOnline: true,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('LG (Online)'),
                    ],
                  ),
                  Column(
                    children: [
                      UserAvatar(
                        imageUrl: 'https://ui-avatars.com/api/?name=Carlos+Mendes&background=06B6D4&color=ffffff',
                        initials: 'CM',
                        size: AvatarSize.xl,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('XL'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // SeÃ§Ã£o de Post Card
            Text(
              'Card de Postagem',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            PostCard(
              authorName: 'JoÃ£o Silva',
              authorAvatar: 'https://ui-avatars.com/api/?name=JoÃ£o+Silva&background=6C63FF&color=ffffff',
              content: 'Este Ã© um exemplo de postagem no Design System. Os cards possuem efeito de sombra suave e bordas arredondadas para uma aparÃªncia moderna e minimalista.',
              imageUrl: 'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=400&h=240&fit=crop',
              timestamp: DateTime.now().subtract(const Duration(hours: 2)),
              likes: 156,
              comments: 23,
              isLikedByMe: false,
              onLike: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Curtido!')),
              ),
              onComment: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrir comentÃ¡rios')),
              ),
              onShare: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartilhar')),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // SeÃ§Ã£o de Cores
            Text(
              'Paleta de Cores',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                _ColorTile('PrimÃ¡rio', AppColors.primary),
                _ColorTile('PrimÃ¡rio Dark', AppColors.primaryDark),
                _ColorTile('SecundÃ¡rio', AppColors.secondary),
                _ColorTile('Sucesso', AppColors.success),
                _ColorTile('Erro', AppColors.error),
                _ColorTile('Aviso', AppColors.warning),
                _ColorTile('Info', AppColors.info),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorTile(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.md.toDouble()),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

