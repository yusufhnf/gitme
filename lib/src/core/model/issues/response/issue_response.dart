import '../../users/response/users_response.dart';

class IssuesResponse {
  int? totalCount;
  bool? incompleteResults;
  List<IssueItem>? items;

  IssuesResponse({this.totalCount, this.incompleteResults, this.items});

  IssuesResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <IssueItem>[];
      json['items'].forEach((v) {
        items!.add(IssueItem.fromJson(v));
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

class IssueItem {
  late int id;
  String? title;
  String? state;
  String? updatedAt;
  List<Labels>? labels;
  UserItem? users;

  String get stateText {
    if (state == "open") {
      return "Open";
    }
    return "Closed";
  }

  bool get isStateOpen {
    if (state == "open") {
      return true;
    }
    return false;
  }

  IssueItem(
      {required this.id, this.title, this.state, this.updatedAt, this.labels});

  IssueItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    state = json['state'];
    updatedAt = json['updated_at'];
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels!.add(Labels.fromJson(v));
      });
    }
    users = json['user'] != null ? UserItem.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['state'] = state;
    data['updated_at'] = updatedAt;
    if (labels != null) {
      data['labels'] = labels!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['user'] = users!.toJson();
    }
    return data;
  }
}

class Labels {
  String? name;

  Labels({this.name});

  Labels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
