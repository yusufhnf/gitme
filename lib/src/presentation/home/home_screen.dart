import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../infrastructure/widgets/widgets.dart';
import '../../core/model/issues/response/issue_response.dart';
import '../../core/model/repositories/response/repositories_response.dart';
import '../../core/model/users/response/users_response.dart';
import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/utils/resources/resources.dart';
import '../../presentation/home/cell/issues_cell.dart';
import '../../presentation/home/cell/repositories_cell.dart';
import '../../presentation/home/cell/users_cell.dart';
import '../../presentation/home/cubit/home_cubit.dart';
import '../../presentation/home/cubit/home_state.dart';

part '_radio_sliver.dart';
part '_listtype_sliver.dart';
part '_users_view.dart';
part '_repos_view.dart';
part '_issues_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeCubit>(
        create: (_) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return LazyLoadScrollView(
              onEndOfPage: () {
                if (state.loadType == LoadType.lazy &&
                    state.loadStatus == LoadStatus.success) {
                  context.read<HomeCubit>().loadMore();
                }
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: false,
                    centerTitle: true,
                    elevation: 0.0,
                    title: const Text(Strings.appTitle),
                    bottom: AppBar(
                      title: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        height: Dimension.height36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Pallet.neutralWhite),
                        child: Center(
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return TextField(
                                onChanged: context.read<HomeCubit>().setQuery,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Strings.search,
                                  prefixIcon: Icon(Icons.search),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const RadioSliver(),
                  const ListTypeSliver(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          switch (state.loadStatus) {
                            case LoadStatus.initial:
                              context.read<HomeCubit>().pageNumber = 0;
                              break;
                            default:
                          }
                        },
                        builder: (context, state) {
                          switch (state.loadStatus) {
                            case LoadStatus.initial:
                              return const InfoView(
                                  asset: LottieAssets.searchInitial,
                                  message: Strings.insertKey);
                            case LoadStatus.loading:
                              return const LoadingAnimation();
                            case LoadStatus.success:
                              switch (state.searchType) {
                                case SearchType.users:
                                  return UserList(users: state.users);
                                case SearchType.repositories:
                                  return const ReposList();
                                case SearchType.issues:
                                  return const IssueList();
                                default:
                              }
                              break;
                            case LoadStatus.failed:
                              return const InfoView(
                                  asset: LottieAssets.error,
                                  message: Strings.failed);
                            case LoadStatus.empty:
                              return const InfoView(
                                  asset: LottieAssets.searchNotFound,
                                  message: Strings.searchNotFound);
                            default:
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
