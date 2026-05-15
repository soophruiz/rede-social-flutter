# Design System - Quick Reference

## 🎨 Resumo Executivo

O SENN.AI Social implementa um Design System profissional e moderno baseado em Material Design 3, com suporte completo a tema claro/escuro, componentes estilizados e tokenização de design.

## 🚀 Começar Rápido

### Usar a Paleta de Cores
```dart
import 'package:rede_social/src/design_system/colors.dart';

// Primária
AppColors.primary        // #6C63FF
AppColors.primaryDark    // #5A52D5
AppColors.primaryLight   // #8B7FFF

// Secundária
AppColors.secondary      // #2563EB

// Status
AppColors.success        // #10B981
AppColors.error          // #EF4444
AppColors.warning        // #FB923C
AppColors.info           // #06B6D4
```

### Usar Espaçamento
```dart
import 'package:rede_social/src/design_system/spacing.dart';

Padding(
  padding: const EdgeInsets.all(AppSpacing.lg),  // 16px
  child: SizedBox(height: AppSpacing.md),        // 12px
)

// BorderRadius padrão
BorderRadius.circular(AppBorderRadius.lg)  // 16px
```

### Usar Tipografia
```dart
import 'package:rede_social/src/design_system/typography.dart';

// Em Widgets, use TextTheme do Material:
Text(
  'Título',
  style: Theme.of(context).textTheme.headlineMedium,
)

Text(
  'Corpo',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

### Usar Componentes
```dart
import 'package:rede_social/src/components/index.dart';

// Botão com gradiente
PrimaryButton(
  label: 'Enviar',
  onPressed: () {},
  icon: Icons.send,
)

// Card de postagem
PostCard(
  authorName: 'João Silva',
  authorAvatar: 'https://...',
  content: 'Conteúdo da postagem',
  timestamp: DateTime.now(),
  onLike: () {},
  onComment: () {},
  onShare: () {},
)

// Input customizado
CustomTextInput(
  label: 'E-mail',
  hintText: 'seu@email.com',
  prefixIcon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
)

// Glass card (glassmorphism)
GlassCard(
  child: Text('Card com efeito vidro'),
  blur: 10,
)

// Avatar do usuário
UserAvatar(
  imageUrl: 'https://...',
  size: AvatarSize.lg,
  isOnline: true,
)
```

## 📐 Espaçamento Padrão

| Token | Valor | Uso |
|-------|-------|-----|
| `xs` | 4px | Gaps muito pequenos |
| `sm` | 8px | Gaps pequenos |
| `md` | 12px | Gaps médios |
| `lg` | 16px | Gaps padrão |
| `xl` | 24px | Gaps grandes |
| `xxl` | 32px | Gaps muito grandes |
| `xxxl` | 48px | Gaps extremos |

## 🎨 Cores Funcionais

| Cor | Hex | Uso |
|-----|-----|-----|
| Primária | #6C63FF | CTAs, destaque principal |
| Secundária | #2563EB | Links, ações secundárias |
| Sucesso | #10B981 | Confirmações, status OK |
| Erro | #EF4444 | Erros, validações negativas |
| Aviso | #FB923C | Avisos, caution |
| Info | #06B6D4 | Informações, dicas |

## 🌓 Modo Claro vs Escuro

O app detecta automaticamente o tema do sistema, mas permite alteração manual:

```dart
// Em _RedeSocialAppState
void _toggleTheme() {
  setState(() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  });
}
```

## 📦 Estrutura de Imports

**Design System**:
```dart
import 'package:rede_social/src/design_system/colors.dart';
import 'package:rede_social/src/design_system/spacing.dart';
import 'package:rede_social/src/design_system/theme.dart';
```

**Componentes**:
```dart
import 'package:rede_social/src/components/index.dart';
```

**Tudo**:
```dart
import 'package:rede_social/src/design_system/index.dart';
import 'package:rede_social/src/components/index.dart';
```

## ✅ Checklist ao Criar Componentes

- [ ] Use `AppColors.*` ao invés de cores hardcoded
- [ ] Use `AppSpacing.*` para todos os paddings/margins
- [ ] Use `AppBorderRadius.lg` (16px) para cards/buttons
- [ ] Teste em modo claro E escuro
- [ ] Adicione sombras com `AppShadows.*`
- [ ] Suporte responsividade
- [ ] Documente com comentários `///`
- [ ] Exporte em `index.dart`

## 🎯 Exemplo Completo

```dart
import 'package:flutter/material.dart';
import 'src/design_system/colors.dart';
import 'src/design_system/spacing.dart';
import 'src/components/primary_button.dart';
import 'src/components/custom_text_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              CustomTextInput(
                label: 'E-mail',
                hintText: 'email@example.com',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                validator: (v) => v?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              PrimaryButton(
                label: 'Entrar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ação
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🔗 Recursos

- [Design System Completo](DESIGN_SYSTEM.md)
- [Showcase de Componentes](lib/showcase.dart)
- [Flutter Documentation](https://flutter.dev)
- [Material Design 3](https://m3.material.io)

## 📞 Suporte

Para dúvidas sobre o Design System, consulte:
1. `DESIGN_SYSTEM.md` - documentação completa
2. `lib/showcase.dart` - exemplos práticos
3. Código-fonte dos componentes em `lib/src/components/`

---

**Design System v1.0** | Flutter 3.10+ | Material 3 | May 2026
