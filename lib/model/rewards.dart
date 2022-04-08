import 'dart:convert';

class RewardModel {
  final String rewardId;
  final String description;
  bool isCollected;

  RewardModel(
      {required this.rewardId,
      required this.description,
      this.isCollected = false});

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
        description: json['description'] as String,
        isCollected: json['isC'] as bool,
        rewardId: json['rewardId'] as String);
  }

  String toJson() {
    return jsonEncode({
      "rewardId": this.isCollected,
      "description": this.description,
      "isC": this.isCollected
    });
  }
}
