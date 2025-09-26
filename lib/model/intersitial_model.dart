class IntersitialModel {
  final bool splashIntersitial;

  IntersitialModel({required this.splashIntersitial});

  factory IntersitialModel.fromJson(Map<dynamic, dynamic> json) {
    return IntersitialModel(
      splashIntersitial: json['splash_view'] ?? 'Default welcome',
    );
  }

  /// default empty
  factory IntersitialModel.empty() {
    return IntersitialModel(splashIntersitial: false);
  }
}
