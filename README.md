# SENN.AI Social

Aplicativo de rede social completo criado com Flutter, implementando um **Design System profissional** com modo claro/escuro, componentes estilizados e validação de autenticação.

## 🎯 Funcionalidades

### Telas
- ✅ **Splash Screen** com logo animada
- ✅ **Login** com validação
- ✅ **Cadastro** com validação
- ✅ **Feed** de postagens
- ✅ **Perfil** com edição
- ✅ **Mensagens** diretas
- ✅ **Notificações**

### Design System
- ✅ **Temas** claro e escuro (Light/Dark)
- ✅ **Tipografia** Google Fonts Poppins
- ✅ **Paleta de cores** moderna e minimalista
- ✅ **Componentes estilizados** com Material 3
- ✅ **Efeito Glassmorphism** em cards
- ✅ **Sombras e bordas** personalizadas

## 🎨 Design System

### Componentes
1. **PrimaryButton** - Botão com gradiente e sombra
2. **PostCard** - Card de postagem com ações
3. **CustomTextInput** - Campo de entrada customizado
4. **GlassCard** - Card com efeito glassmorphism
5. **UserAvatar** - Avatar com status online

### Tokens de Design
- **Cores**: Primária #6C63FF, Secundária #2563EB
- **Spacing**: xs (4px), sm (8px), md (12px), lg (16px), xl (24px), xxl (32px)
- **BorderRadius**: 4px a 16px
- **Tipografia**: 5 níveis de títulos + corpo + labels

### Temas
- **Modo Claro**: Backgrounds claros, textos escuros
- **Modo Escuro**: Backgrounds escuros, textos claros
- **Responsivo**: Tema automático baseado no sistema

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                           # Entrada do app
├── showcase.dart                       # Showcase de componentes
├── src/
│   ├── app_state.dart                 # Gerenciador de estado (Provider)
│   ├── models.dart                    # Modelos de dados
│   ├── design_system/
│   │   ├── colors.dart                # Paleta de cores
│   │   ├── typography.dart            # Tipografia Poppins
│   │   ├── spacing.dart               # Espaçamento e bordas
│   │   ├── theme_extension.dart       # Extensões de tema
│   │   ├── theme.dart                 # Temas claro/escuro
│   │   └── index.dart                 # Exports centralizados
│   ├── components/
│   │   ├── primary_button.dart        # Botão com gradiente
│   │   ├── post_card.dart             # Card de postagem
│   │   ├── custom_text_input.dart     # Input field customizado
│   │   ├── glass_card.dart            # Card glassmorphism
│   │   ├── user_avatar.dart           # Avatar de usuário
│   │   └── index.dart                 # Exports centralizados
│   └── pages/
│       ├── splash_screen.dart         # Tela de abertura
│       ├── login_screen.dart          # Tela de login
│       ├── register_screen.dart       # Tela de cadastro
│       ├── home_screen.dart           # Tela principal
│       ├── feed_page.dart             # Feed de postagens
│       ├── messages_page.dart         # Mensagens
│       ├── notifications_page.dart    # Notificações
│       └── profile_page.dart          # Perfil do usuário
```

## 🔐 Credenciais de Teste

Use este usuário para testar o login:

- **E-mail**: `aluno@senn.ai`
- **Senha**: `Senn@123`

## 🚀 Como Executar

1. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

2. **Execute o app**:
   ```bash
   flutter run
   ```

3. **Visualize o Design System Showcase**:
   ```dart
   // Altere em main.dart a home para:
   home: DesignSystemShowcase(),
   ```

## 📱 Compatibilidade

- ✅ iOS (iPhone 13+)
- ✅ Android (5.0+)
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🎨 Paleta de Cores

| Cor | Hex | Uso |
|-----|-----|-----|
| Primária | #6C63FF | Botões, ícones, destaque |
| Secundária | #2563EB | Links, acento |
| Sucesso | #10B981 | Status positivo |
| Erro | #EF4444 | Erros, alertas |
| Aviso | #FB923C | Avisos |
| Info | #06B6D4 | Informações |

## 📝 Tipografia

- **Fonte**: Google Fonts - Poppins
- **Títulos**: Semi-bold (600)
- **Corpo**: Regular (400)
- **Labels**: Medium (500)

## 🔧 Dependências

```yaml
provider: ^6.1.5+1           # Gerenciamento de estado
google_fonts: ^8.1.0          # Fontes Google
supabase_flutter: ^2.12.4    # Backend (opcional)
image_picker: ^1.2.2          # Seletor de imagem
intl: ^0.20.2                 # Internacionalização
```

## 📚 Documentação

Veja [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) para:
- Documentação completa dos componentes
- Exemplos de uso
- Melhores práticas
- Guia de estilo

## 🔄 Integração Supabase

Um exemplo de autenticação com Supabase está em `supabase_auth.js`:

```javascript
import { signIn, signUp, validateCredentials } from './supabase_auth.js';

// Autenticar usuário
const user = await signIn('email@example.com', 'password');

// Registrar usuário
const newUser = await signUp('João', 'joao@email.com', 'senha123');

// Validar credenciais
const isValid = await validateCredentials('email@example.com', 'password');
```

## ✨ Características Principais

### Design
- ✅ Material Design 3
- ✅ Modo claro/escuro automático
- ✅ Glassmorphism
- ✅ Animações fluidas
- ✅ Ripple effects

### UX/UI
- ✅ Validação em tempo real
- ✅ Feedback visual
- ✅ Acessibilidade
- ✅ Responsividade
- ✅ Performance otimizada

### Desenvolvimento
- ✅ Arquitetura escalável
- ✅ Componentes reutilizáveis
- ✅ Design tokens centralizados
- ✅ TypeSafe
- ✅ Lint rules ativadas

## 👨‍💻 Desenvolvimento

### Adicionar novo componente

1. Crie o arquivo em `lib/src/components/`
2. Estenda `StatelessWidget` ou `StatefulWidget`
3. Use tokens de design (cores, spacing, etc)
4. Exporte em `lib/src/components/index.dart`

### Usar o Design System

```dart
import 'package:rede_social/src/design_system/index.dart';
import 'package:rede_social/src/components/index.dart';

// Usar cores
Container(
  color: AppColors.primary,
)

// Usar espaçamento
SizedBox(height: AppSpacing.lg)

// Usar componentes
PrimaryButton(
  label: 'Enviar',
  onPressed: () {},
)
```

## 📊 Estatísticas

- **Linhas de Código**: ~2000+
- **Componentes**: 5 estilizados
- **Screens**: 7 telas
- **Tokens de Design**: 40+

## 🤝 Contribuindo

Este é um projeto educacional do SENN.AI. Para melhorias, considere:

1. Manter a consistência de design
2. Usar tokens de design
3. Adicionar testes
4. Documentar mudanças

## 📄 Licença

Desenvolvido para o SENN.AI em May 2026.

---

**Design System Version**: 1.0.0  
**Flutter Version**: 3.10+  
**Framework**: Material 3  
**State Management**: Provider
