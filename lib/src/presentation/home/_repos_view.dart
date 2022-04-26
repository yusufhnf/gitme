part of 'home_screen.dart';

class ReposList extends StatelessWidget {
  const ReposList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RepositoryItem> repos =
        context.watch<HomeCubit>().loadRepositoriesValue;
    return Column(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          padding: EdgeInsets.all(Dimension.width16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => RepositoriesCell(repo: repos[index]),
          itemCount: repos.length,
        ),
        if (context.watch<HomeCubit>().loadTypeValue == LoadType.pagination)
          const IndexPagination()
      ],
    );
  }
}
