# Design System - SENN.AI Social

Documentação completa do Design System implementado para o SENN.AI Social, um aplicativo de rede social moderno com suporte a modo claro e escuro.

## 📋 Estrutura

```
lib/src/design_system/
├── colors.dart              # Paleta de cores
├── typography.dart          # Tipografia (Google Fonts - Poppins)
├── spacing.dart             # Espaçamento e bordas
├── theme_extension.dart     # Extensões de tema personalizadas
└── theme.dart              # Temas claro/escuro completos

lib/src/components/
├── primary_button.dart      # Botão primário com gradiente
├── post_card.dart          # Card de postagem
├── custom_text_input.dart  # Campo de texto customizado
├── glass_card.dart         # Card com glassmorphism
└── user_avatar.dart        # Avatar de usuário
```

## 🎨 Paleta de Cores

### Cores Primárias
- **Primária**: `#6C63FF` (Roxo)
- **Primária Dark**: `#5A52D5`
- **Primária Light**: `#8B7FFF`

### Cores Secundárias
- **Secundária**: `#2563EB` (Azul)
- **Secundária Dark**: `#1D4ED8`
- **Secundária Light**: `#3B82F6`

### Backgrounds
- **Claro**: `#F5F7FA`
- **Escuro**: `#121212`
- **Superfície Escura**: `#1E1E1E`

### Texto
- **Claro**: `#2D3436`
- **Claro Secundário**: `#636E72`
- **Escuro**: `#FFFFFF`
- **Escuro Secundário**: `#B0B0B0`

### Status
- **Sucesso**: `#10B981`
- **Erro**: `#EF4444`
- **Aviso**: `#FB923C`
- **Info**: `#06B6D4`

## 📝 Tipografia

Usando **Google Fonts - Poppins**

### Títulos
- **Heading XL**: 32px, Semi-bold
- **Heading LG**: 28px, Semi-bold
- **Heading MD**: 24px, Semi-bold
- **Heading SM**: 20px, Semi-bold
- **Heading XS**: 18px, Semi-bold

### Corpo
- **Body LG**: 16px, Regular
- **Body MD**: 14px, Regular
- **Body SM**: 12px, Regular
- **Body XS**: 10px, Regular

### Labels
- **Label LG**: 14px, Medium (500)
- **Label MD**: 12px, Medium (500)
- **Label SM**: 10px, Medium (500)

## 🔲 Espaçamento

```dart
AppSpacing.xs    = 4px
AppSpacing.sm    = 8px
AppSpacing.md    = 12px
AppSpacing.lg    = 16px
AppSpacing.xl    = 24px
AppSpacing.xxl   = 32px
AppSpacing.xxxl  = 48px
```

## 🔘 Border Radius

```dart
AppBorderRadius.xs     = 4px
AppBorderRadius.sm     = 8px
AppBorderRadius.md     = 12px
AppBorderRadius.lg     = 16px     // Padrão para cards
AppBorderRadius.xl     = 24px
AppBorderRadius.full   = 9999px
```

## 🌟 Componentes

### 1. PrimaryButton
Botão primário com gradiente e sombra suave.

```dart
PrimaryButton(
  label: 'Enviar',
  onPressed: () {},
  icon: Icons.send,
  isLoading: false,
)
```

**Recursos**:
- Gradiente customizado
- Sombra suave
- Estado de loading
- Suporte a ícone
- Animação de pressão

### 2. PostCard
Card de postagem com bordas arredondadas e estilo premium.

```dart
PostCard(
  authorName: 'João Silva',
  authorAvatar: 'https://...',
  content: 'Conteúdo da postagem',
  timestamp: DateTime.now(),
  likes: 25,
  comments: 5,
  isLikedByMe: false,
  onLike: () {},
  onComment: () {},
  onShare: () {},
)
```

**Recursos**:
- Header com avatar e hora
- Suporte a imagem
- Estatísticas (curtidas/comentários)
- Ações (curtir, comentar, compartilhar)
- Sombra adaptativa claro/escuro

### 3. CustomTextInput
Campo de entrada com bordas suaves e ícones personalizados.

```dart
CustomTextInput(
  label: 'E-mail',
  hintText: 'Digite seu e-mail',
  prefixIcon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
  validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
)
```

**Recursos**:
- Label acima do campo
- Suporte a prefixIcon e suffixIcon
- Animação no foco com sombra
- Validação integrada
- Modo obscuro para senhas
- Tema responsivo (claro/escuro)

### 4. GlassCard
Card com efeito glassmorphism (vidro fosco).

```dart
GlassCard(
  child: Text('Conteúdo com glassmorphism'),
  blur: 10,
  onTap: () {},
)
```

**Recursos**:
- Efeito de vidro fosco com BackdropFilter
- Bordas personalizáveis
- Tema adaptativo
- Touch interativo

### 5. UserAvatar
Avatar de usuário com status online opcional.

```dart
UserAvatar(
  imageUrl: 'https://...',
  size: AvatarSize.lg,
  isOnline: true,
  initials: 'JS',
)
```

**Tamanhos**:
- `AvatarSize.xs` (radius: 16)
- `AvatarSize.sm` (radius: 20)
- `AvatarSize.md` (radius: 28)
- `AvatarSize.lg` (radius: 40)
- `AvatarSize.xl` (radius: 56)

## 🌓 Modo Claro vs Escuro

O tema é responsivo e ajusta automaticamente:
- Cores
- Tipografia
- Sombras
- Bordas
- Backgrounds

### Usar tema do sistema
```dart
themeMode: ThemeMode.system
```

### Alternar entre temas
```dart
// Em _RedeSocialAppState
setState(() {
  _themeMode = _themeMode == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
});
```

## 💄 Sombras

```dart
AppShadows.xs    // Sombra mínima
AppShadows.sm    // Sombra pequena
AppShadows.md    // Sombra média
AppShadows.lg    // Sombra grande
AppShadows.xl    // Sombra extra grande
AppShadows.glassLight  // Sombra para glass (claro)
AppShadows.glassDark   // Sombra para glass (escuro)
```

## 🎯 Exemplo de Integração

```dart
import 'package:flutter/material.dart';
import 'src/design_system/colors.dart';
import 'src/design_system/spacing.dart';
import 'src/components/primary_button.dart';
import 'src/components/custom_text_input.dart';

class ExampleScreen extends StatefulWidget {
  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              CustomTextInput(
                label: 'E-mail',
                hintText: 'seu@email.com',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              PrimaryButton(
                label: 'Confirmar',
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

## 🚀 Melhores Práticas

1. **Sempre use os tokens de design**: Use `AppSpacing.lg` em vez de valores hardcoded
2. **Reutilize componentes**: Use os widgets fornecidos para consistência
3. **Respeite o padding**: Use espaçamento padronizado entre elementos
4. **Teste em ambos os temas**: Sempre teste em modo claro e escuro
5. **Acessibilidade**: Verifique contraste de cores e tamanho de texto
6. **Performance**: Use `const` widgets quando possível

## 📱 Responsividade

O Design System é totalmente responsivo e funciona em:
- ✅ iOS (iPhone 13-15)
- ✅ Android (5.0+)
- ✅ Web (Flutter Web)

---

**Design System Version**: 1.0.0  
**Last Updated**: May 2026  
**Framework**: Flutter 3.10+  
**Dependencies**: google_fonts, provider
