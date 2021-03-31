import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction {edit, delete}

class UserTile<T> extends StatelessWidget {

  final Widget child;

  final Function(SlidableAction action) onDismissed;

  const UserTile({
    @required this.child,
    @required this.onDismissed,
    Key key,
  }):super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
    actionPane: SlidableDrawerActionPane(),
    child: child,

    ///right side
    secondaryActions: [
      IconSlideAction(
        caption: 'Edit',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () => onDismissed(SlidableAction.edit),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => onDismissed(SlidableAction.delete),
      )
    ],
  );
}
