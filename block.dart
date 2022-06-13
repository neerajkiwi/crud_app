import 'package:flutter/material.dart';
import 'package:login_sharedprefernece/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:login_sharedprefernece/block.dart';

class Block extends StatefulWidget {
  const Block({Key? key}) : super(key: key);

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Blocked User')),
      ),
      body: userProvider.getBlockedUsers.isEmpty
          ? const Center(
              child: Text('no block user'),
            )
          : ListView.builder(
              itemCount: userProvider.getBlockedUsers.length,
              itemBuilder: (context, i) => Column(
                    children: [
                      const Divider(
                        height: 10.0,
                      ),
                      Slidable(
                        key: const ValueKey(1),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            // A SlidableAction can have an icon and/or a label.

                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('are you sure'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'no');
                                                } //upadate the ui
                                                ,
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  int id = context
                                                      .read<UserProvider>()
                                                      .getBlockedUsers[i]
                                                      .id;

                                                  context
                                                      .read<UserProvider>()
                                                      .unblockUser(id);

                                                  Navigator.pop(context, 'yes');
                                                },
                                                child: const Text('Yes'))
                                          ],
                                        ));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.block,
                              label: 'unblock',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.grey,
                              backgroundImage: (userProvider.getBlockedUsers[i]
                                              .userFileImagePath ==
                                          null) &&
                                      (userProvider.getBlockedUsers[i].url ==
                                          null)
                                  ? const AssetImage('images/index.png')
                                  : userProvider.getBlockedUsers[i].url != null
                                      ? NetworkImage(
                                          userProvider.getBlockedUsers[i].url!)
                                      : FileImage(userProvider
                                          .getBlockedUsers[i]
                                          .userFileImagePath!) as ImageProvider
                              //,
                              ),
                          subtitle: Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              userProvider.getBlockedUsers[i].name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
    );
    //const Center(child: Text('No Block Users'));
  }
}
