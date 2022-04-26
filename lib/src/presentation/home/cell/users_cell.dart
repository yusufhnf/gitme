import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitme/src/core/model/users/response/users_response.dart';
import 'package:gitme/src/infrastructure/theme/theme.dart';

class UsersCell extends StatelessWidget {
  const UsersCell({Key? key, required this.user}) : super(key: key);
  final UserItem user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(user.login ?? "-", style: TextStyles.regularNormalBold),
      leading: CachedNetworkImage(
        imageUrl: user.avatarUrl ?? "-",
        width: Dimension.width44,
        height: Dimension.width44,
        errorWidget: (context, _, __) => const Icon(Icons.error),
      ),
    );
  }
}
