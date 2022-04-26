import '../../users/response/users_response.dart';

class RepositoriesResponse {
  int? totalCount;
  bool? incompleteResults;
  List<RepositoryItem>? items;

  RepositoriesResponse({this.totalCount, this.incompleteResults, this.items});

  RepositoriesResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <RepositoryItem>[];
      json['items'].forEach((v) {
        items!.add(RepositoryItem.fromJson(v));
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

class RepositoryItem {
  String? name;
  late int id;
  String? createdAt;
  int? stargazersCount;
  int? watchersCount;
  int? forksCount;
  UserItem? owner;

  RepositoryItem(
      {this.name,
      required this.id,
      this.createdAt,
      this.stargazersCount,
      this.watchersCount,
      this.forksCount,
      this.owner});

  RepositoryItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    createdAt = json['created_at'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    forksCount = json['forks_count'];
    owner = json['owner'] != null ? UserItem.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['forks_count'] = forksCount;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}
