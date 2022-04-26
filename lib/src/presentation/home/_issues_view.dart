part of 'home_screen.dart';

class IssueList extends StatelessWidget {
  const IssueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IssueItem> issues = context.watch<HomeCubit>().loadIssuesValue;
    return Column(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          padding: EdgeInsets.all(Dimension.width16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => IssuesCell(issue: issues[index]),
          itemCount: issues.length,
        ),
        if (context.watch<HomeCubit>().loadTypeValue == LoadType.pagination)
          const IndexPagination()
      ],
    );
  }
}
