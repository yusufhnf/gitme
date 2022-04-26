import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitme/src/core/model/issues/response/issue_response.dart';
import 'package:gitme/src/core/model/repositories/response/repositories_response.dart';
import 'package:gitme/src/core/model/users/response/users_response.dart';
import 'package:gitme/src/core/network/api_provider.dart';
import 'package:gitme/src/presentation/home/cubit/home_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final _apiProvider = APIProvider();
  BehaviorSubject<String> searchQuery = BehaviorSubject<String>();
  int limitPerPage = 30;
  int pageNumber = 0;
  int pageLength = 0;
  String queryTemp = '';
  Timer? _debounce;

  SearchType get searchTypeValue => state.searchTypeValue;
  LoadType get loadTypeValue => state.loadTypeValue;
  List<UserItem> get loadUsersValue => state.loadUsers;
  List<RepositoryItem> get loadRepositoriesValue => state.loadRepositories;
  List<IssueItem> get loadIssuesValue => state.loadIssues;

  void setSearchTypeValue(SearchType type) {
    pageNumber = 0;
    emit(state.copyWith(search: type));
    emit(state.copyWith(status: LoadStatus.loading));
    onSearching();
  }

  void setLoadTypeValue(LoadType type) {
    pageNumber = 0;
    emit(state.copyWith(type: type));
    emit(state.copyWith(status: LoadStatus.loading));
    onSearching();
  }

  void setQuery(String value) {
    queryTemp = value;
    emit(state.copyWith(status: LoadStatus.loading));
    onSearching();
  }

  void loadMore() async {
    pageNumber += 1;
    switch (searchTypeValue) {
      case SearchType.users:
        getUsers(isLoadMore: true);
        break;
      case SearchType.repositories:
        break;
      case SearchType.issues:
        break;
      default:
    }
  }

  void navigatePagination(int value) async {
    pageNumber = value;
    onSearching();
  }

  Future<void> onSearching() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (queryTemp.isEmpty) {
        emit(state.copyWith(status: LoadStatus.initial));
        return;
      }
      emit(state.copyWith(status: LoadStatus.loading));
      switch (searchTypeValue) {
        case SearchType.users:
          await getUsers();
          break;
        case SearchType.repositories:
          await getRepositories();
          break;
        case SearchType.issues:
          await getIssues();
          break;
        default:
      }
    });
  }

  Future<void> getUsers({bool isLoadMore = false}) async {
    try {
      UsersResponse users = await _apiProvider.getUsers(
          searchKey: queryTemp,
          pageLimit: limitPerPage,
          pageNumber: pageNumber + 1);
      if (users.items?.isEmpty ?? true) {
        emit(state.copyWith(status: LoadStatus.empty));
      } else {
        final int resultCount = users.totalCount ?? 0;
        pageLength = resultCount ~/ limitPerPage;
        if (isLoadMore) {
          List<UserItem> updatedUsers = loadUsersValue;
          updatedUsers.addAll(users.items ?? []);
          emit(state.copyWith(status: LoadStatus.loadmore));
          emit(state.copyWith(
              usersResult: updatedUsers, status: LoadStatus.success));
        } else {
          emit(state.copyWith(
              usersResult: users.items, status: LoadStatus.success));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: LoadStatus.failed));
    }
  }

  Future<void> getRepositories() async {
    try {
      RepositoriesResponse repo = await _apiProvider.getRepositories(
          searchKey: queryTemp,
          pageLimit: limitPerPage,
          pageNumber: pageNumber + 1);
      if (repo.items?.isEmpty ?? true) {
        emit(state.copyWith(status: LoadStatus.empty));
      } else {
        final int resultCount = repo.totalCount ?? 0;
        pageLength = resultCount ~/ limitPerPage;
        emit(
            state.copyWith(repoResult: repo.items, status: LoadStatus.success));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: LoadStatus.failed));
    }
  }

  Future<void> getIssues() async {
    try {
      IssuesResponse issue = await _apiProvider.getIssues(
          searchKey: queryTemp,
          pageLimit: limitPerPage,
          pageNumber: pageNumber + 1);
      if (issue.items?.isEmpty ?? true) {
        emit(state.copyWith(status: LoadStatus.empty));
      } else {
        final int resultCount = issue.totalCount ?? 0;
        pageLength = resultCount ~/ limitPerPage;
        emit(state.copyWith(
            issuesResult: issue.items, status: LoadStatus.success));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: LoadStatus.failed));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
