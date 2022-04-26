part of 'home_screen.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.users}) : super(key: key);
  final List<UserItem> users;

  @override
  Widget build(BuildContext context) {
    // List<UserItem> users = context.watch<HomeCubit>().loadUsersValue;
    return Column(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          padding: EdgeInsets.all(Dimension.width16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => UsersCell(user: users[index]),
          itemCount: users.length,
        ),
        if (context.watch<HomeCubit>().loadTypeValue == LoadType.pagination)
          const IndexPagination()
      ],
    );
  }
}
