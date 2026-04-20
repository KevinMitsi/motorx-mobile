class NotificationModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String urgency;
  final bool isRead;
  final String? readAt;
  final String? source;
  final String createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.urgency,
    required this.isRead,
    required this.readAt,
    required this.source,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      urgency: json['urgency']?.toString() ?? 'LOW',
      isRead: json['isRead'] == true,
      readAt: json['readAt']?.toString(),
      source: json['source']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
