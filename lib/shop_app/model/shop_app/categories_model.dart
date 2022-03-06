class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJason(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data = [];
  CategoriesDataModel.fromJason(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJason(element));
    });
  }
}

class DataModel {
  int? id;
  String name = '';
  String image = '';
  DataModel.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
