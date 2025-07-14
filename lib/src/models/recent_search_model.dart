class RecentSearch {
  final int searchLogId;
  final int eventId;
  final String eventName;

  RecentSearch({
    required this.searchLogId,
    required this.eventId,
    required this.eventName,
  });

  factory RecentSearch.fromJson(Map<String, dynamic> json) {
    return RecentSearch(
      searchLogId: json['search_log_id'],
      eventId: json['event_id'],
      eventName: json['event_name'],
    );
  }
}
