class SupportRequest {
  final String title;
  final String subtitle;
  final String time;
  final String icon;
  final bool isNew;
  final int newCount;

  SupportRequest({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    this.isNew = false,
    this.newCount = 0,
  });
}
