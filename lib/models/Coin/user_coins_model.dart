class UserCoinsModel {
  final bool success;
  final int totalCoins;

  UserCoinsModel({
    required this.success,
    required this.totalCoins,
  });

  factory UserCoinsModel.fromJson(Map<String, dynamic> json) {
    return UserCoinsModel(
      success: json['success'] ?? false,
      totalCoins: json['totalCoins'] ?? 0,
    );
  }
}
