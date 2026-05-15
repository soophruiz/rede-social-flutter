import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../app_state.dart';

// Página principal de mensagens
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = context.watch<AppState>();
    final conversations = state.conversations;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: conversations.isEmpty
          ? _buildEmptyState()
          : _buildConversationList(conversations, state),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma conversa encontrada',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Suas conversas aparecerão aqui',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationList(conversations, state) {
    return RefreshIndicator(
      onRefresh: () async {
        await state.refreshConversations();
      },
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: conversations.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return _buildConversationTile(conversation, context);
        },
      ),
    );
  }

  Widget _buildConversationTile(conversation, BuildContext context) {
    final timeAgo = _getTimeAgo(conversation.lastMessageTime);
    final hasUnread = conversation.unreadCount > 0;

    return Material(
      color: hasUnread ? Colors.blue.withOpacity(0.05) : Colors.transparent,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: context.read<AppState>(),
                child: ChatPage(conversationId: conversation.id),
              ),
            ),
          );
        },
        onLongPress: () => _showConversationOptions(context, conversation),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              // Avatar com indicador online
              Stack(
                children: [
                  Hero(
                    tag: 'avatar_${conversation.id}',
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: hasUnread ? const Color(0xFF2563EB) : Colors.grey[300],
                      backgroundImage: conversation.avatarUrl != null
                          ? NetworkImage(conversation.avatarUrl!)
                          : null,
                      child: conversation.avatarUrl == null
                          ? Text(
                              conversation.title[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: hasUnread ? Colors.white : Colors.grey[600],
                              ),
                            )
                          : null,
                    ),
                  ),
                  if (conversation.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Informações da conversa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            conversation.title,
                            style: TextStyle(
                              fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w600,
                              fontSize: 16,
                              color: hasUnread ? Colors.black : Colors.grey[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 12,
                            color: hasUnread ? const Color(0xFF2563EB) : Colors.grey[500],
                            fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (conversation.isTyping)
                          _buildTypingIndicator()
                        else
                          Expanded(
                            child: Text(
                              conversation.subtitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: hasUnread ? Colors.grey[700] : Colors.grey[500],
                                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        if (hasUnread)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Digitando',
          style: TextStyle(
            fontSize: 13,
            color: const Color(0xFF2563EB),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: 20,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Row(
                children: List.generate(3, (index) {
                  final delay = index * 0.2;
                  final opacity = ((value + delay) % 1.0) * 0.5 + 0.5;
                  return Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB).withOpacity(opacity),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showConversationOptions(BuildContext context, conversation) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.push_pin_outlined),
                  title: Text(conversation.isPinned ? 'Desafixar' : 'Fixar conversa'),
                  onTap: () {
                    context.read<AppState>().togglePinConversation(conversation.id);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_off_outlined),
                  title: Text(conversation.isMuted ? 'Ativar notificações' : 'Silenciar'),
                  onTap: () {
                    context.read<AppState>().toggleMuteConversation(conversation.id);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.archive_outlined, color: Colors.grey[700]),
                  title: const Text('Arquivar'),
                  onTap: () {
                    context.read<AppState>().archiveConversation(conversation.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Conversa arquivada'),
                        action: SnackBarAction(
                          label: 'Desfazer',
                          onPressed: () {
                            context.read<AppState>().unarchiveConversation(conversation.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Excluir conversa', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Excluir conversa?'),
                        content: const Text('Esta ação não pode ser desfeita.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppState>().deleteConversation(conversation.id);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return DateFormat('dd/MM/yy').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'Agora';
    }
  }
}

// Página de chat melhorada
class ChatPage extends StatefulWidget {
  final String conversationId;

  const ChatPage({required this.conversationId, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  bool _showScrollToBottom = false;
  String? _replyingTo;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();

    _scrollController.addListener(() {
      if (_scrollController.offset < _scrollController.position.maxScrollExtent - 100) {
        if (!_showScrollToBottom) setState(() => _showScrollToBottom = true);
      } else {
        if (_showScrollToBottom) setState(() => _showScrollToBottom = false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _fadeController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleTypingIndicator() {
    _typingTimer?.cancel();
    context.read<AppState>().setTypingStatus(widget.conversationId, true);

    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AppState>().setTypingStatus(widget.conversationId, false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final conversation = state.conversations.firstWhere(
      (item) => item.id == widget.conversationId,
      orElse: () => throw Exception('Conversa não encontrada'),
    );

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(conversation, state),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _buildMessageList(conversation),
                    if (_showScrollToBottom)
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: _buildScrollToBottomButton(),
                      ),
                  ],
                ),
              ),
              if (_replyingTo != null) _buildReplyPreview(),
              const Divider(height: 1),
              _buildMessageInput(state),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(conversation, state) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF2563EB),
      title: Row(
        children: [
          Hero(
            tag: 'avatar_${conversation.id}',
            child: CircleAvatar(
              radius: 18,
              backgroundImage: conversation.avatarUrl != null
                  ? NetworkImage(conversation.avatarUrl!)
                  : null,
              child: conversation.avatarUrl == null
                  ? Text(
                      conversation.title[0].toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (conversation.isOnline || conversation.isTyping)
                  Text(
                    conversation.isTyping ? 'Digitando...' : 'Online',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone_outlined),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chamada de voz iniciando...')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chamada de vídeo iniciando...')),
            );
          },
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'search':
                _showSearchDialog();
                break;
              case 'media':
                _showMediaGallery();
                break;
              case 'info':
                _showConversationInfo();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'search',
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Text('Buscar mensagens'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'media',
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 8),
                  Text('Mídia'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 8),
                  Text('Informações'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageList(conversation) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: conversation.messages.length,
      itemBuilder: (context, index) {
        final message = conversation.messages[index];
        final showDateHeader = _shouldShowDateHeader(conversation.messages, index);
        final showSenderInfo = !message.mine && _shouldShowSenderInfo(conversation.messages, index);

        return Column(
          children: [
            if (showDateHeader) _buildDateHeader(message.timestamp),
            _buildMessageBubble(message, conversation.messages, index, showSenderInfo),
          ],
        );
      },
    );
  }

  bool _shouldShowDateHeader(List messages, int index) {
    if (index == 0) return true;
    final current = messages[index].timestamp;
    final previous = messages[index - 1].timestamp;
    return current.difference(previous).inDays >= 1;
  }

  bool _shouldShowSenderInfo(List messages, int index) {
    if (index == 0) return true;
    return messages[index - 1].senderId != messages[index].senderId;
  }

  Widget _buildDateHeader(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatDateHeader(date),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Hoje';
    } else if (date.day == now.day - 1 && date.month == now.month && date.year == now.year) {
      return 'Ontem';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  Widget _buildMessageBubble(message, List messages, int index, bool showSenderInfo) {
    final alignment = message.mine ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = message.mine ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9);
    final textColor = message.mine ? Colors.white : const Color(0xFF0F172A);
    final timeColor = message.mine ? const Color(0xB3FFFFFF) : const Color(0x8A0F172A);

    return Align(
      alignment: alignment,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(context, message),
        onDoubleTap: () => _toggleReaction(message),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(message.mine ? 20 : 4),
                bottomRight: Radius.circular(message.mine ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showSenderInfo && !message.mine)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                    child: Text(
                      message.senderName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                if (message.replyTo != null)
                  _buildReplyBubble(message.replyTo, message.mine),
                if (message.mediaUrl != null)
                  _buildMediaMessage(message),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: message.mine ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.Hm().format(message.timestamp),
                        style: TextStyle(color: timeColor, fontSize: 11),
                      ),
                      if (message.mine) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: message.isRead ? Colors.blue[200] : timeColor,
                        ),
                      ],
                    ],
                  ),
                ),
                if (message.reactions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      message.reactions.join(' '),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReplyBubble(replyTo, bool isMine) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isMine ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: isMine ? Colors.white : const Color(0xFF2563EB),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            replyTo.senderName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isMine ? Colors.white : const Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            replyTo.text,
            style: TextStyle(
              fontSize: 12,
              color: isMine ? Colors.white70 : Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMediaMessage(message) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        message.mediaUrl!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.error_outline, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildReplyPreview() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Respondendo a',
                  style: TextStyle(
                    color: const Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  _replyingTo!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => setState(() => _replyingTo = null),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file_outlined),
            color: Colors.grey[600],
            onPressed: _showAttachmentOptions,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              onChanged: (_) => _handleTypingIndicator(),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Digite uma mensagem...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      color: Colors.grey[600],
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Emojis em breve!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Material(
              color: _messageController.text.trim().isNotEmpty
                  ? const Color(0xFF2563EB)
                  : Colors.grey[300],
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  if (_messageController.text.trim().isNotEmpty) {
                    state.sendMessage(
                      widget.conversationId,
                      _messageController.text.trim(),
                      replyTo: _replyingTo,
                    );
                    _messageController.clear();
                    setState(() => _replyingTo = null);
                    _scrollToBottom();
                  }
                },
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.send_rounded,
                    color: _messageController.text.trim().isNotEmpty
                        ? Colors.white
                        : Colors.grey[500],
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollToBottomButton() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.white,
      onPressed: _scrollToBottom,
      child: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF2563EB)),
    );
  }

  void _showMessageOptions(BuildContext context, message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Reações rápidas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['👍', '❤️', '😂', '😮', '😢', '😡'].map((emoji) {
                      return GestureDetector(
                        onTap: () {
                          context.read<AppState>().addReaction(
                            widget.conversationId,
                            message.id,
                            emoji,
                          );
                          Navigator.pop(context);
                        },
                        child: Text(emoji, style: const TextStyle(fontSize: 28)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.reply),
                  title: const Text('Responder'),
                  onTap: () {
                    setState(() => _replyingTo = message.text);
                    Navigator.pop(context);
                    _focusNode.requestFocus();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.content_copy),
                  title: const Text('Copiar'),
                  onTap: () {
                    // Implementar cópia para clipboard
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mensagem copiada!')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star_outline),
                  title: const Text('Favoritar'),
                  onTap: () {
                    context.read<AppState>().toggleFavoriteMessage(
                      widget.conversationId,
                      message.id,
                    );
                    Navigator.pop(context);
                  },
                ),
                if (message.mine)
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                      _messageController.text = message.text;
                      _focusNode.requestFocus();
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Excluir', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Excluir mensagem?'),
                        content: const Text('Esta ação não pode ser desfeita.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppState>().deleteMessage(
                                widget.conversationId,
                                message.id,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAttachmentOption(
                  icon: Icons.photo_camera,
                  color: Colors.purple,
                  label: 'Câmera',
                ),
                _buildAttachmentOption(
                  icon: Icons.photo_library,
                  color: Colors.blue,
                  label: 'Galeria',
                ),
                _buildAttachmentOption(
                  icon: Icons.insert_drive_file,
                  color: Colors.orange,
                  label: 'Documento',
                ),
                _buildAttachmentOption(
                  icon: Icons.location_on,
                  color: Colors.green,
                  label: 'Localização',
                ),
                _buildAttachmentOption(
                  icon: Icons.contact_phone,
                  color: Colors.teal,
                  label: 'Contato',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption({required IconData icon, required Color color, required String label}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label em breve!')),
        );
      },
    );
  }

  void _toggleReaction(message) {
    context.read<AppState>().addReaction(
      widget.conversationId,
      message.id,
      '❤️',
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final searchController = TextEditingController();
        return AlertDialog(
          title: const Text('Buscar mensagens'),
          content: TextField(
            controller: searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Digite para buscar...',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (query) {
              // Implementar busca
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showMediaGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Galeria de mídia em breve!')),
    );
  }

  void _showConversationInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informações da conversa em breve!')),
    );
  }
}