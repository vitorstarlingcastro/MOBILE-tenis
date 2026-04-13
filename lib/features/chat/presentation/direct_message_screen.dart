import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// TODO (Phase 3): replace with real ChatMessage model from WS /chat/ws/{room_id}
class _ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  const _ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

// TODO (Phase 3): replace with messages loaded from WebSocket stream
const _mockMessages = [
  _ChatMessage(text: 'Ei, quer jogar amanhã?', isMe: false, time: '13:40'),
  _ChatMessage(text: 'Claro! Que horas você tem disponível?', isMe: true, time: '13:41'),
  _ChatMessage(text: 'Posso das 18h em diante', isMe: false, time: '13:41'),
  _ChatMessage(text: 'Perfeito. Quadra do clube às 18h30?', isMe: true, time: '13:42'),
  _ChatMessage(text: 'O treino de amanhã está confirmado então! Te vejo lá 🎾', isMe: false, time: 'AGORA'),
];

class DirectMessageScreen extends StatefulWidget {
  // TODO (Phase 3): pass real UserResponse from GET /users/{id}/profile
  final String contactName;
  final Color contactColor;
  final bool isOnline;

  const DirectMessageScreen({
    super.key,
    this.contactName = 'Rafael Varane',
    this.contactColor = const Color(0xFF4A90E2),
    this.isOnline = true,
  });

  @override
  State<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO (Phase 3): replace with messages from WebSocket provider
  final List<_ChatMessage> _messages = List.of(_mockMessages);

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    // TODO (Phase 3): send via WS /chat/ws/{room_id}
    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true, time: 'AGORA'));
    });
    _inputController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) =>
                    _buildBubble(_messages[index]),
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textSecondary,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Stack(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.contactColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.contactName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (widget.isOnline)
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contactName,
                    style: AppTextStyles.bodyBold(14)),
                Text(
                  widget.isOnline ? 'Online' : 'Offline',
                  style: AppTextStyles.body(11,
                      color: widget.isOnline
                          ? AppColors.primary
                          : AppColors.textSecondary),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.sports_tennis,
                  color: AppColors.textSecondary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bubble ───────────────────────────────────────────────────────────────

  Widget _buildBubble(_ChatMessage msg) {
    final isMe = msg.isMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: widget.contactColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.contactName[0].toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppRadius.md),
                      topRight: const Radius.circular(AppRadius.md),
                      bottomLeft: Radius.circular(
                          isMe ? AppRadius.md : AppRadius.sm),
                      bottomRight: Radius.circular(
                          isMe ? AppRadius.sm : AppRadius.md),
                    ),
                  ),
                  child: Text(
                    msg.text,
                    style: AppTextStyles.body(13,
                        color: isMe
                            ? AppColors.onPrimary
                            : AppColors.textPrimary),
                  ),
                ),
                const SizedBox(height: 3),
                Text(msg.time,
                    style: AppTextStyles.body(9,
                        color: AppColors.textSecondary)),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 4),
        ],
      ),
    );
  }

  // ─── Input Bar ────────────────────────────────────────────────────────────

  Widget _buildInputBar() {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceLow,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: TextField(
                controller: _inputController,
                style: AppTextStyles.body(14,
                    color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Mensagem...',
                  hintStyle: AppTextStyles.body(14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: neonGlow(),
              ),
              child: const Icon(Icons.arrow_upward,
                  color: AppColors.onPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
