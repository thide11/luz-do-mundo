class Activity {
  String id;
  String title;
  String description;
  ActivityType type;
  int? amountSpend;
  
  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.amountSpend,
  });
}

enum ActivityType {
  ACTION_PLAN,
  HISTORIC,
}