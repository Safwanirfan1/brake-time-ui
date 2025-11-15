
import 'package:flutter/material.dart';
import 'chat_with_dashboard.dart';

/// BreakTime Chat Screen — Claude-like layout with sidebar + theme detection.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_Conversation> _conversations = [
    _Conversation(
      title: 'Welcome',
      messages: [
        _Message(text: 'Welcome to BrakeTime — demo conversation.', isUser: false),
      ],
      theme: '🗨️ General',
    ),
  ];

  int _selectedConversation = 0;

  List<_Message> get _messages => _conversations[_selectedConversation].messages;

  /// Create a new chat with a default title and theme
  void _createNewChat() {
    setState(() {
      const defaultTheme = '🗨️ General';
      const defaultTitle = 'New Chat';
      _conversations.insert(
        0,
        _Conversation(title: defaultTitle, messages: [], theme: defaultTheme),
      );
      _selectedConversation = 0;
    });
    Navigator.maybePop(context);
  }

  /// Select a chat conversation
  void _selectConversation(int index) {
    setState(() => _selectedConversation = index);
    Navigator.maybePop(context);
  }

  //Handle chat actions like download/share/delete
  void _onConversationAction(String action, int index) {
    // if (action == 'download') {
    //   Navigator.push(
    //     context,
       // MaterialPageRoute(
          //builder: (_) => const DownloadSuccessScreen(folderPath: ''),
      //  ),
     // );
      if (action == 'share') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Share not implemented')));
    } else if (action == 'delete') {
      setState(() {
        _conversations.removeAt(index);
        if (_selectedConversation >= _conversations.length) {
          _selectedConversation =
              _conversations.isEmpty ? 0 : _conversations.length - 1;
        }
      });
    }
  }

  /// Send a new chat message and simulate a response
  void _sendMessage() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;

    setState(() {
      _messages.add(_Message(text: txt, isUser: true));
      _messages.add(_Message(text: '[[LOGO_PLACEHOLDER]] $txt', isUser: false));
    });

    final theme = _detectTheme(txt);
    debugPrint('Detected Theme: $theme');

    _controller.clear();

    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  /// Detects a simple theme based on message text
  String _detectTheme(String text) {
    final t = text.toLowerCase();
    // ignore: avoid_print
    print('🧩 Detecting theme for: $text'); // debug print

   

    if (t.contains('climate') ||
        t.contains('global warming') ||
        t.contains('carbon') ||
        t.contains('emission')) {return '🌍 Climate Change';}

    if (t.contains('econom') ||
        t.contains('finance') ||
        t.contains('stock') ||
        t.contains('revenue')) {return '💰 Finance';}

    if (t.contains('sport') ||
        t.contains('football') ||
        t.contains('cricket')) {return '🏅 Sports';}

    if (t.contains('health') ||
        t.contains('doctor') ||
        t.contains('exercise')) {return '💊 Health';}

    if (t.contains('tech') ||
        t.contains('ai') ||
        t.contains('flutter') ||
        t.contains('app')) {return '💻 Technology';}

    if (t.contains('food') ||
        t.contains('cook') ||
        t.contains('recipe')) {return '🍲 Food';}

    if (t.contains('travel') || t.contains('hotel') || t.contains('tour')) {
      return '✈️ Travel';
    }

    if (t.contains('politic') || t.contains('election')) return '🏛️ Politics';

    if (t.contains('science') || t.contains('space')) return '🔬 Science';

    return '🗨️ General';
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      drawer: isWide ? null : Drawer(child: _sidePanel()),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide)
              SizedBox(width: 300, child: _sidePanel()),
            Expanded(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 780),
                  child: Column(
                    children: [
                      _header(context),
                      const Divider(height: 1),
                      Expanded(child: _messageList()),
                      _inputBar(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header bar
  Widget _header(BuildContext context) {
    final size = (MediaQuery.of(context).size.width * 0.05).clamp(18.0, 28.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          Builder(
            builder: (ctx) => MediaQuery.of(context).size.width < 900
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  )
                : const SizedBox(),
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              children: const [
                TextSpan(
                    text: 'Brake',
                    style: TextStyle(color: Color.fromARGB(255, 2, 103, 18))),
                TextSpan(
                    text: 'Time',
                    style: TextStyle(color: Color.fromARGB(255, 3, 250, 61))),
              ],
            ),
          ),
          const Spacer(),
          DashboardButton(
            isEnabled: true,
            isGlowing: true,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const DashboardScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: Curves.easeInOut));
                    return SlideTransition(
                        position: animation.drive(tween), child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// Sidebar
  Widget _sidePanel() {
    return Material(
      color: Colors.grey.shade50,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton.icon(
                onPressed: _createNewChat,
                icon: const Icon(Icons.add),
                label: const Text('New Chat'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  elevation: 0,
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: _conversations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, idx) {
                  final c = _conversations[idx];
                  return ListTile(
                    selected: idx == _selectedConversation,
                    title: Text(c.title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                      c.theme ??
                          (c.messages.isNotEmpty
                              ? c.messages.last.text
                              : ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => _selectConversation(idx),
                    trailing: PopupMenuButton<String>(
                      onSelected: (v) => _onConversationAction(v, idx),
                      itemBuilder: (_) => const [
                        //PopupMenuItem(value: 'download', child: Text('Download')),
                        PopupMenuItem(value: 'share', child: Text('Share')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'BrakeTime corner market',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Chat message list
  Widget _messageList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _messages.length,
      itemBuilder: (context, revIdx) {
        final idx = _messages.length - 1 - revIdx;
        final m = _messages[idx];
        final isUser = m.isUser;
        final bg = isUser ? const Color(0xFF13834B) : const Color(0xFFF1F3F4);
        final textColor = isUser ? Colors.white : Colors.black87;

        return Align(
          alignment:
              isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.58,
            ),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: m.text.contains('[[LOGO_PLACEHOLDER]]')
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/logo2.png'),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          m.text
                              .replaceFirst('[[LOGO_PLACEHOLDER]]', '')
                              .trim(),
                          style:
                              TextStyle(color: textColor, fontSize: 15),
                        ),
                      ),
                    ],
                  )
                : Text(m.text,
                    style:
                        TextStyle(color: textColor, fontSize: 15)),
          ),
        );
      },
    );
  }

  /// Input bar
  Widget _inputBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: const Color(0xFF01aa07),
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _Conversation {
  String title;
  List<_Message> messages;
  String? theme;

  _Conversation({required this.title, required this.messages, this.theme});
}

class _Message {
  final String text;
  final bool isUser;

  _Message({required this.text, required this.isUser});
}

/// Dashboard button widget
class DashboardButton extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;
  final bool isGlowing;

  const DashboardButton({
    required this.isEnabled,
    this.onPressed,
    this.isGlowing = false,
    super.key,
  });

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _glowAnimation =
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut);

    if (widget.isGlowing) _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: widget.isGlowing
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 70, 229, 73)
                          .withValues(alpha:0.3 + (_glowAnimation.value * 0.4)),
                      blurRadius: 8 + (_glowAnimation.value * 8),
                      spreadRadius: 2 + (_glowAnimation.value * 3),
                    ),
                  ],
                )
              : null,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isEnabled ? widget.onPressed : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: widget.isEnabled
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(12),
                  border: widget.isGlowing
                      ? Border.all(
                          color: const Color.fromARGB(121, 9, 255, 0)
                              .withValues(alpha:0.6 + (_glowAnimation.value * 0.4)),
                          width: 2,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // Icon(Icons.dashboard_outlined, size: 18, color: Colors.white),
                    // SizedBox(width: 8),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
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
}