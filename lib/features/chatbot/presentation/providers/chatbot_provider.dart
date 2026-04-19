import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/chatbot_remote_datasource.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});
}

class ChatbotState {
  final bool isLoading;
  final List<ChatMessage> messages;

  const ChatbotState({this.isLoading = false, this.messages = const []});

  ChatbotState copyWith({bool? isLoading, List<ChatMessage>? messages}) {
    return ChatbotState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
    );
  }
}

final chatbotDatasourceProvider = Provider<ChatbotRemoteDatasource>((ref) {
  return ChatbotRemoteDatasource(ref.watch(dioClientProvider));
});

class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final Ref _ref;

  ChatbotNotifier(this._ref)
    : super(
        const ChatbotState(
          messages: [
            ChatMessage(
              text:
                  'Hola, soy el asistente de MotorX. Puedo ayudarte con servicios, citas y repuestos.',
              isUser: false,
            ),
          ],
        ),
      );

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    state = state.copyWith(
      isLoading: true,
      messages: [
        ...state.messages,
        ChatMessage(text: message.trim(), isUser: true),
      ],
    );

    try {
      final ds = _ref.read(chatbotDatasourceProvider);
      final reply = await ds.sendMessage(message.trim());
      state = state.copyWith(
        isLoading: false,
        messages: [
          ...state.messages,
          ChatMessage(text: reply, isUser: false),
        ],
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        messages: [
          ...state.messages,
          ChatMessage(
            text: 'No pude responder en este momento: $e',
            isUser: false,
          ),
        ],
      );
    }
  }
}

final chatbotNotifierProvider =
    StateNotifierProvider<ChatbotNotifier, ChatbotState>((ref) {
      return ChatbotNotifier(ref);
    });
