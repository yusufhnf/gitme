class UsersResponse {
  int? totalCount;
  bool? incompleteResults;
  List<UserItem>? items;

  UsersResponse({this.totalCount, this.incompleteResults, this.items});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <UserItem>[];
      json['items'].forEach((v) {
        items!.add(UserItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserItem {
  String? login;
  late int id;
  String? avatarUrl;

  UserItem({this.login, required this.id, this.avatarUrl});

  UserItem.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
