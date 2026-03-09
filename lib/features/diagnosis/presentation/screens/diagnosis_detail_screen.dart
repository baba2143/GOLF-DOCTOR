import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:golf_doctor_app/features/diagnosis/data/diagnosis_repository.dart';
import 'package:golf_doctor_app/core/models/diagnosis.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final diagnosisDetailProvider =
    FutureProvider.autoDispose.family<Diagnosis?, String>((ref, id) async {
  final repo = ref.read(diagnosisRepositoryProvider);
  return repo.getDiagnosis(id);
});

class DiagnosisDetailScreen extends ConsumerStatefulWidget {
  final String diagnosisId;

  const DiagnosisDetailScreen({super.key, required this.diagnosisId});

  @override
  ConsumerState<DiagnosisDetailScreen> createState() =>
      _DiagnosisDetailScreenState();
}

class _DiagnosisDetailScreenState extends ConsumerState<DiagnosisDetailScreen> {
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diagnosisAsync = ref.watch(diagnosisDetailProvider(widget.diagnosisId));
    final currentUserId = SupabaseService.currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断詳細'),
      ),
      body: diagnosisAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(child: Text('エラー: $error')),
        data: (diagnosis) {
          if (diagnosis == null) {
            return const Center(child: Text('診断が見つかりません'));
          }

          final isUser = diagnosis.userId == currentUserId;
          final isPro = diagnosis.proId == currentUserId;
          final messages = diagnosis.messages ?? [];

          return Column(
            children: [
              // Header info
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isUser
                                ? '${diagnosis.pro?.name ?? "プロ"}への依頼'
                                : '${diagnosis.user?.name ?? "ユーザー"}からの依頼',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          _buildStatusRow(diagnosis),
                        ],
                      ),
                    ),
                    Text(
                      '¥${diagnosis.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMine = message.senderId == currentUserId;
                    return _MessageBubble(
                      message: message,
                      isMine: isMine,
                    );
                  },
                ),
              ),

              // Input area
              if (_canSendMessage(diagnosis, isUser, isPro))
                _buildInputArea(diagnosis, isUser, isPro),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusRow(Diagnosis diagnosis) {
    final dateFormat = DateFormat('MM/dd HH:mm');

    return Row(
      children: [
        _buildStatusChip(diagnosis.status),
        const SizedBox(width: 8),
        if (diagnosis.status == DiagnosisStatus.pending)
          Text(
            '期限: ${dateFormat.format(diagnosis.deadlineAt)}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        if (diagnosis.status == DiagnosisStatus.answered)
          Text(
            '追加質問: ${diagnosis.followupCount}/${diagnosis.maxFollowups}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }

  Widget _buildStatusChip(DiagnosisStatus status) {
    Color color;
    String label;

    switch (status) {
      case DiagnosisStatus.pending:
        color = AppColors.statusPending;
        label = '回答待ち';
        break;
      case DiagnosisStatus.inProgress:
        color = AppColors.statusInProgress;
        label = '回答中';
        break;
      case DiagnosisStatus.answered:
        color = AppColors.statusAnswered;
        label = '回答済み';
        break;
      case DiagnosisStatus.expired:
        color = AppColors.statusExpired;
        label = '期限切れ';
        break;
      case DiagnosisStatus.refunded:
        color = AppColors.statusRefunded;
        label = '返金済み';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  bool _canSendMessage(Diagnosis diagnosis, bool isUser, bool isPro) {
    if (diagnosis.status == DiagnosisStatus.expired ||
        diagnosis.status == DiagnosisStatus.refunded) {
      return false;
    }

    // Pro can answer if pending
    if (isPro && diagnosis.status == DiagnosisStatus.pending) {
      return true;
    }

    // User can followup if answered and under limit
    if (isUser &&
        diagnosis.status == DiagnosisStatus.answered &&
        diagnosis.followupCount < diagnosis.maxFollowups) {
      return true;
    }

    // Pro can answer followup
    if (isPro && diagnosis.status == DiagnosisStatus.inProgress) {
      return true;
    }

    return false;
  }

  Widget _buildInputArea(Diagnosis diagnosis, bool isUser, bool isPro) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.surfaceVariant),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isPro && diagnosis.status == DiagnosisStatus.pending) ...[
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Video recording/selection
                },
                icon: const Icon(Icons.videocam),
                label: const Text('動画で回答する'),
              ),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                if (isUser) ...[
                  IconButton(
                    icon: const Icon(Icons.videocam),
                    onPressed: () {
                      // TODO: Video upload
                    },
                  ),
                ],
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: isUser ? '追加質問を入力...' : '回答を入力...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: _isSending
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  color: AppColors.primary,
                  onPressed: _isSending ? null : () => _sendMessage(diagnosis),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(Diagnosis diagnosis) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSending = true);

    try {
      final repo = ref.read(diagnosisRepositoryProvider);
      final currentUserId = SupabaseService.currentUserId;
      final isUser = diagnosis.userId == currentUserId;

      MessageType messageType;
      if (isUser) {
        messageType = MessageType.followup;
      } else {
        // Pro responding
        messageType = diagnosis.status == DiagnosisStatus.pending
            ? MessageType.answer
            : MessageType.followupAnswer;
      }

      await repo.addMessage(
        diagnosisId: diagnosis.id,
        messageType: messageType,
        text: text,
      );

      _messageController.clear();
      ref.invalidate(diagnosisDetailProvider(widget.diagnosisId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('送信に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }
}

class _MessageBubble extends StatelessWidget {
  final DiagnosisMessage message;
  final bool isMine;

  const _MessageBubble({
    required this.message,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd HH:mm');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMine) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceVariant,
              child: Text(
                (message.sender?.name ?? 'U')[0].toUpperCase(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMine ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMine ? 16 : 4),
                  bottomRight: Radius.circular(isMine ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message type badge
                  _buildTypeBadge(),
                  const SizedBox(height: 4),

                  // Video if present
                  if (message.videoUrl != null) ...[
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Text
                  if (message.text != null && message.text!.isNotEmpty)
                    Text(
                      message.text!,
                      style: TextStyle(
                        color: isMine ? Colors.white : AppColors.textPrimary,
                      ),
                    ),

                  // Timestamp
                  const SizedBox(height: 4),
                  Text(
                    dateFormat.format(message.createdAt),
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          isMine ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMine) const SizedBox(width: 8 + 32), // Space for avatar
        ],
      ),
    );
  }

  Widget _buildTypeBadge() {
    String label;
    switch (message.messageType) {
      case MessageType.initial:
        label = '依頼';
        break;
      case MessageType.answer:
        label = '回答';
        break;
      case MessageType.followup:
        label = '追加質問';
        break;
      case MessageType.followupAnswer:
        label = '追加回答';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isMine
            ? Colors.white.withValues(alpha: 0.2)
            : AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isMine ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}
