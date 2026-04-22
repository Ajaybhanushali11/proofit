class ClaimModel {
  final String id;
  final String claimText;
  final String sourceType;
  final int score;
  final List<String> explanation;
  final String summary;
  final int views;
  final DateTime? createdAt;

  ClaimModel({
    required this.id,
    required this.claimText,
    required this.sourceType,
    required this.score,
    required this.explanation,
    required this.summary,
    required this.views,
    this.createdAt,
  });

  factory ClaimModel.fromJson(Map<String, dynamic> json) {
    return ClaimModel(
      id: json['_id']?.toString() ?? '',
      claimText: json['claimText'] ?? '',
      sourceType: json['sourceType'] ?? 'text',
      score: json['score'] ?? 0,
      explanation: (json['explanation'] as List<dynamic>? ?? []).map((e) => '$e').toList(),
      summary: json['summary'] ?? '',
      views: json['views'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }
}
