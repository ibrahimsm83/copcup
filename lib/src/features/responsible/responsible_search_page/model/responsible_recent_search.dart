class ResponsibleRecentSearch {
  final int searchLogId;
  final String foodItemName;
  final String foodCategoryname;

  ResponsibleRecentSearch({
    required this.searchLogId,
    required this.foodItemName,
    required this.foodCategoryname,
  });

  factory ResponsibleRecentSearch.fromJson(Map<String, dynamic> json) {
    return ResponsibleRecentSearch(
      searchLogId: json['search_log_id'],
      foodItemName: json['foodItem_name'] ?? '',
      foodCategoryname: json['foodCategory_name'] ?? '',
    );
  }
}
