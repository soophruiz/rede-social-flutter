// Thomas e Sophia DEVB
import 'package:flutter/material.dart';

// ============ MODELOS ============

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final String? avatarUrl;
  final String? coverUrl;
  final List<String> followers;
  final List<String> following;
  final List<Post> posts;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.avatarUrl,
    this.coverUrl,
    List<String>? followers,
    List<String>? following,
    List<Post>? posts,
  })  : followers = followers ?? [],
        following = following ?? [],
        posts = posts ?? [];

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    String? avatarUrl,
    String? coverUrl,
    List<String>? followers,
    List<String>? following,
    List<Post>? posts,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
    );
  }
}

class Post {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final List<String> likes;
  final List<Comment> comments;
  final bool isLiked;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    List<String>? likes,
    List<Comment>? comments,
    this.isLiked = false,
  })  : likes = likes ?? [],
        comments = comments ?? [];

  Post copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? content,
    String? imageUrl,
    DateTime? timestamp,
    List<String>? likes,
    List<Comment>? comments,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final DateTime timestamp;
  final List<String> likes;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.timestamp,
    List<String>? likes,
  }) : likes = likes ?? [];

  Comment copyWith({
    String? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? timestamp,
    List<String>? likes,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
    );
  }
}

class NotificationItem {
  final String id;
  final String type;
  final String fromUserName;
  final String? fromUserAvatar;
  final String? postId;
  final String? content;
  final DateTime timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.fromUserName,
    this.fromUserAvatar,
    this.postId,
    this.content,
    required this.timestamp,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    String? type,
    String? fromUserName,
    String? fromUserAvatar,
    String? postId,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      fromUserName: fromUserName ?? this.fromUserName,
      fromUserAvatar: fromUserAvatar ?? this.fromUserAvatar,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

class Conversation {
  final String id;
  final String title;
  final String subtitle;
  final int unreadCount;
  final String? avatarUrl;
  final bool isOnline;
  final bool isTyping;
  final bool isPinned;
  final bool isMuted;
  final bool isArchived;
  final DateTime lastMessageTime;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.title,
    required this.subtitle,
    this.unreadCount = 0,
    this.avatarUrl,
    this.isOnline = false,
    this.isTyping = false,
    this.isPinned = false,
    this.isMuted = false,
    this.isArchived = false,
    required this.lastMessageTime,
    List<Message>? messages,
  }) : messages = messages ?? [];

  Conversation copyWith({
    String? id,
    String? title,
    String? subtitle,
    int? unreadCount,
    String? avatarUrl,
    bool? isOnline,
    bool? isTyping,
    bool? isPinned,
    bool? isMuted,
    bool? isArchived,
    DateTime? lastMessageTime,
    List<Message>? messages,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      unreadCount: unreadCount ?? this.unreadCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
      isTyping: isTyping ?? this.isTyping,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      isArchived: isArchived ?? this.isArchived,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      messages: messages ?? this.messages,
    );
  }
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime timestamp;
  final bool mine;
  final bool isRead;
  final String? mediaUrl;
  final String? replyTo;
  final List<String> reactions;
  final bool isFavorite;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
    this.mine = false,
    this.isRead = false,
    this.mediaUrl,
    this.replyTo,
    List<String>? reactions,
    this.isFavorite = false,
  }) : reactions = reactions ?? [];

  Message copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? text,
    DateTime? timestamp,
    bool? mine,
    bool? isRead,
    String? mediaUrl,
    String? replyTo,
    List<String>? reactions,
    bool? isFavorite,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      mine: mine ?? this.mine,
      isRead: isRead ?? this.isRead,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      replyTo: replyTo ?? this.replyTo,
      reactions: reactions ?? this.reactions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// ============ APP STATE ============

class AppState extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  List<UserModel> _users = [];
  List<Post> _posts = [];
  List<Conversation> _conversations = [];
  List<NotificationItem> _notifications = [];

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  List<UserModel> get suggestedUsers =>
      _users.where((u) => u.id != _currentUser?.id).take(5).toList();

  List<Post> get feedPosts => List.from(_posts)
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  List<Post> get posts => _posts;

  List<Conversation> get conversations {
    final sorted = List<Conversation>.from(_conversations);
    sorted.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.lastMessageTime.compareTo(a.lastMessageTime);
    });
    return sorted.where((c) => !c.isArchived).toList();
  }

  List<NotificationItem> get notifications =>
      List.from(_notifications)..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  AppState() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _users = [
      UserModel(id: '1', name: 'JoÃ£o Silva', email: 'joao@email.com', bio: 'Desenvolvedor Flutter'),
      UserModel(id: '2', name: 'Maria Santos', email: 'maria@email.com', bio: 'Designer UX/UI'),
      UserModel(id: '3', name: 'Pedro Costa', email: 'pedro@email.com', bio: 'Full Stack Developer'),
    ];

    _posts = [
      Post(
        id: 'post1', userId: '1', userName: 'JoÃ£o Silva',
        content: 'Acabei de finalizar um projeto incrÃ­vel em Flutter! ðŸš€',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        likes: ['2'],
        comments: [
          Comment(
            id: 'comment1', userId: '2', userName: 'Maria Santos',
            content: 'ParabÃ©ns! Ficou muito bom!',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
      Post(
        id: 'post2', userId: '2', userName: 'Maria Santos',
        content: 'Novo design system pronto!',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        likes: ['1', '3'],
        comments: [],
      ),
    ];

    _conversations = [
      Conversation(
        id: 'conv1', title: 'Maria Santos',
        subtitle: 'VocÃª: AtÃ© amanhÃ£! ðŸ‘‹',
        isOnline: true,
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
        messages: [
          Message(
            id: 'msg1', senderId: 'me', senderName: 'Eu',
            text: 'AtÃ© amanhÃ£! ðŸ‘‹',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            mine: true, isRead: false,
          ),
        ],
      ),
    ];

    _notifications = [
      NotificationItem(
        id: 'notif1', type: 'like', fromUserName: 'Maria Santos',
        content: 'curtiu seu post',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      NotificationItem(
        id: 'notif2', type: 'follow', fromUserName: 'Ana Oliveira',
        content: 'comeÃ§ou a seguir vocÃª',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  // AUTENTICAÃ‡ÃƒO
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.length >= 3 && password.length >= 3) {
      _currentUser = UserModel(id: 'current', name: email.split('@')[0], email: email);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (name.isNotEmpty && email.length >= 3 && password.length >= 3) {
      _currentUser = UserModel(id: 'current', name: name, email: email);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void updateProfile({String? name, String? bio, String? avatarUrl, String? coverUrl}) {
    if (_currentUser == null) return;
    _currentUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      bio: bio ?? _currentUser!.bio,
      avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
      coverUrl: coverUrl ?? _currentUser!.coverUrl,
    );
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // USUÃRIOS
  UserModel? getUserById(String userId) {
    try {
      return _users.firstWhere((u) => u.id == userId);
    } catch (_) {
      return null;
    }
  }

  List<UserModel> searchUsers(String query) {
    if (query.isEmpty) return [];
    return _users.where((u) => u.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<Post> searchPosts(String query) {
    if (query.isEmpty) return [];
    return _posts.where((p) => p.content.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void toggleFollow(String userId) {
    if (_currentUser == null) return;
    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final user = _users[userIndex];
    final isFollowing = user.followers.contains(_currentUser!.id);
    
    List<String> updatedFollowers;
    if (isFollowing) {
      updatedFollowers = List.from(user.followers)..remove(_currentUser!.id);
    } else {
      updatedFollowers = List.from(user.followers)..add(_currentUser!.id);
    }

    _users[userIndex] = user.copyWith(followers: updatedFollowers);
    notifyListeners();
  }

  bool isFollowing(String userId) {
    if (_currentUser == null) return false;
    final user = getUserById(userId);
    return user?.followers.contains(_currentUser!.id) ?? false;
  }

  int followersCount(String userId) {
    final user = getUserById(userId);
    return user?.followers.length ?? 0;
  }

  int followingCount(String userId) {
    final user = getUserById(userId);
    return user?.following.length ?? 0;
  }

  // POSTS
  void addPost(String content) {
    if (_currentUser == null || content.isEmpty) return;
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUser!.id,
      userName: _currentUser!.name,
      content: content,
      timestamp: DateTime.now(),
    );
    _posts.add(newPost);
    notifyListeners();
  }

  void toggleLike(String postId) {
    if (_currentUser == null) return;
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = _posts[postIndex];
    final hasLiked = post.likes.contains(_currentUser!.id);
    List<String> updatedLikes;
    
    if (hasLiked) {
      updatedLikes = List.from(post.likes)..remove(_currentUser!.id);
    } else {
      updatedLikes = List.from(post.likes)..add(_currentUser!.id);
    }

    _posts[postIndex] = post.copyWith(likes: updatedLikes, isLiked: !hasLiked);
    notifyListeners();
  }

  void addComment(String postId, String commentText) {
    if (_currentUser == null || commentText.isEmpty) return;
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = _posts[postIndex];
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUser!.id,
      userName: _currentUser!.name,
      content: commentText,
      timestamp: DateTime.now(),
    );

    final updatedComments = List<Comment>.from(post.comments)..add(newComment);
    _posts[postIndex] = post.copyWith(comments: updatedComments);
    notifyListeners();
  }

  void toggleCommentLike(String postId, String commentId) {
    if (_currentUser == null) return;
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = _posts[postIndex];
    final commentIndex = post.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex == -1) return;

    final comment = post.comments[commentIndex];
    final hasLiked = comment.likes.contains(_currentUser!.id);
    List<String> updatedLikes;
    
    if (hasLiked) {
      updatedLikes = List.from(comment.likes)..remove(_currentUser!.id);
    } else {
      updatedLikes = List.from(comment.likes)..add(_currentUser!.id);
    }

    final updatedComments = List<Comment>.from(post.comments);
    updatedComments[commentIndex] = comment.copyWith(likes: updatedLikes);
    _posts[postIndex] = post.copyWith(comments: updatedComments);
    notifyListeners();
  }

  // NOTIFICAÃ‡Ã•ES
  void markNotificationRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;
    _notifications[index] = _notifications[index].copyWith(isRead: true);
    notifyListeners();
  }

  void markAllNotificationsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  // MENSAGENS
  void sendMessage(String conversationId, String text, {String? replyTo}) {
    final conversationIndex = _conversations.indexWhere((c) => c.id == conversationId);
    if (conversationIndex == -1) return;

    final conversation = _conversations[conversationIndex];
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'Eu',
      text: text,
      timestamp: DateTime.now(),
      mine: true,
      isRead: false,
      replyTo: replyTo,
    );

    final updatedMessages = List<Message>.from(conversation.messages)..add(newMessage);
    _conversations[conversationIndex] = conversation.copyWith(
      messages: updatedMessages,
      subtitle: 'VocÃª: $text',
      lastMessageTime: DateTime.now(),
    );
    notifyListeners();
  }

  void togglePinConversation(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    _conversations[index] = _conversations[index].copyWith(
      isPinned: !_conversations[index].isPinned,
    );
    notifyListeners();
  }

  void toggleMuteConversation(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    _conversations[index] = _conversations[index].copyWith(
      isMuted: !_conversations[index].isMuted,
    );
    notifyListeners();
  }

  void archiveConversation(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    _conversations[index] = _conversations[index].copyWith(isArchived: true);
    notifyListeners();
  }

  void unarchiveConversation(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    _conversations[index] = _conversations[index].copyWith(isArchived: false);
    notifyListeners();
  }

  void deleteConversation(String conversationId) {
    _conversations.removeWhere((c) => c.id == conversationId);
    notifyListeners();
  }

  void setTypingStatus(String conversationId, bool isTyping) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    _conversations[index] = _conversations[index].copyWith(isTyping: isTyping);
    notifyListeners();
  }

  void addReaction(String conversationId, String messageId, String reaction) {
    final conversationIndex = _conversations.indexWhere((c) => c.id == conversationId);
    if (conversationIndex == -1) return;

    final conversation = _conversations[conversationIndex];
    final messageIndex = conversation.messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = conversation.messages[messageIndex];
    final updatedReactions = List<String>.from(message.reactions);
    
    if (updatedReactions.contains(reaction)) {
      updatedReactions.remove(reaction);
    } else {
      updatedReactions.add(reaction);
    }

    final updatedMessages = List<Message>.from(conversation.messages);
    updatedMessages[messageIndex] = message.copyWith(reactions: updatedReactions);
    _conversations[conversationIndex] = conversation.copyWith(messages: updatedMessages);
    notifyListeners();
  }

  void toggleFavoriteMessage(String conversationId, String messageId) {
    final conversationIndex = _conversations.indexWhere((c) => c.id == conversationId);
    if (conversationIndex == -1) return;

    final conversation = _conversations[conversationIndex];
    final messageIndex = conversation.messages.indexWhere((m) => m.id == messageId);
    if (messageIndex == -1) return;

    final message = conversation.messages[messageIndex];
    final updatedMessages = List<Message>.from(conversation.messages);
    updatedMessages[messageIndex] = message.copyWith(isFavorite: !message.isFavorite);
    _conversations[conversationIndex] = conversation.copyWith(messages: updatedMessages);
    notifyListeners();
  }

  void deleteMessage(String conversationId, String messageId) {
    final conversationIndex = _conversations.indexWhere((c) => c.id == conversationId);
    if (conversationIndex == -1) return;

    final conversation = _conversations[conversationIndex];
    final updatedMessages = conversation.messages.where((m) => m.id != messageId).toList();
    _conversations[conversationIndex] = conversation.copyWith(
      messages: updatedMessages,
      subtitle: updatedMessages.isNotEmpty ? updatedMessages.last.text : '',
    );
    notifyListeners();
  }

  Future<void> refreshConversations() async {
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}
