class SearchFilterModel {
  List<int> ids;
  String search;
  int categoryId;
  int collectionId;

  SearchFilterModel(
      {this.ids, this.search, this.categoryId, this.collectionId});

  SearchFilterModel.fromJson(Map<String, dynamic> json) {
    ids = json['ids'].cast<int>();
    search = json['search'];
    categoryId = json['category_id'];
    collectionId = json['collection_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ids'] = this.ids;
    data['search'] = this.search;
    data['category_id'] = this.categoryId;
    data['collection_id'] = this.collectionId;
    return data;
  }
}
