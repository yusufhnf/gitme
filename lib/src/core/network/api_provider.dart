import 'package:dio/dio.dart';
import '../model/issues/response/issue_response.dart';
import '../model/repositories/response/repositories_response.dart';
import '../model/users/response/users_response.dart';
import '../network/api_url.dart';
import '../network/http_exception.dart';

class APIProvider {
  final Dio _dio = Dio();

  Future<UsersResponse> getUsers(
      {required String searchKey, int? pageLimit, int? pageNumber}) async {
    Response response = await _dio.get(ApiUrl.users, queryParameters: {
      'q': searchKey,
      "per_page": pageLimit,
      "page": pageNumber
    });
    throwIfNoSuccess(response);
    return UsersResponse.fromJson(response.data);
  }

  Future<RepositoriesResponse> getRepositories(
      {required String searchKey, int? pageLimit, int? pageNumber}) async {
    Response response = await _dio.get(ApiUrl.repositories, queryParameters: {
      'q': searchKey,
      "per_page": pageLimit,
      "page": pageNumber
    });
    throwIfNoSuccess(response);
    return RepositoriesResponse.fromJson(response.data);
  }

  Future<IssuesResponse> getIssues(
      {required String searchKey, int? pageLimit, int? pageNumber}) async {
    Response response = await _dio.get(ApiUrl.issues, queryParameters: {
      'q': searchKey,
      "per_page": pageLimit,
      "page": pageNumber
    });
    throwIfNoSuccess(response);
    return IssuesResponse.fromJson(response.data);
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }
  }
}
