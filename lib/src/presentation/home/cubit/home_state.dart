import 'package:equatable/equatable.dart';
import 'package:gitme/src/core/model/issues/response/issue_response.dart';
import 'package:gitme/src/core/model/repositories/response/repositories_response.dart';
import 'package:gitme/src/core/model/users/response/users_response.dart';
import 'package:gitme/src/infrastructure/utils/resources/resources.dart';

enum SearchType { users, repositories, issues }
enum LoadType { lazy, pagination }
enum LoadStatus { success, failed, empty, loading, initial, loadmore }

class HomeState extends Equatable {
  final SearchType searchType;
  final LoadType loadType;
  final LoadStatus loadStatus;
  final String exceptionError;
  final String searchValue;
  final List<UserItem> users;
  final List<RepositoryItem> repositories;
  final List<IssueItem> issues;

  const HomeState({
    this.searchType = SearchType.users,
    this.loadType = LoadType.lazy,
    this.loadStatus = LoadStatus.initial,
    this.exceptionError = '',
    this.searchValue = '',
    this.users = const [],
    this.repositories = const [],
    this.issues = const [],
  });

  SearchType get searchTypeValue => searchType;
  LoadType get loadTypeValue => loadType;
  List<UserItem> get loadUsers => users;
  List<RepositoryItem> get loadRepositories => repositories;
  List<IssueItem> get loadIssues => issues;

  @override
  List<Object?> get props => [searchType, loadStatus, loadType, exceptionError];

  HomeState copyWith(
      {SearchType? search,
      LoadType? type,
      LoadStatus? status,
      String? error,
      String? searchValue,
      List<UserItem>? usersResult,
      List<RepositoryItem>? repoResult,
      List<IssueItem>? issuesResult}) {
    return HomeState(
        searchType: search ?? searchType,
        loadType: type ?? loadType,
        loadStatus: status ?? loadStatus,
        exceptionError: error ?? Strings.failed,
        searchValue: searchValue ?? '',
        users: usersResult ?? [],
        repositories: repoResult ?? [],
        issues: issuesResult ?? []);
  }
}
