class RoutesModel {
  String id_user;

  RoutesModel({
    this.id_user,
  });

  RoutesModel.fromJsonMap(Map<String, dynamic> user) {
    this.id_user = (user["id_user"]);
  }
}
