import 'package:flutter/material.dart';
import 'package:login_sharedprefernece/add_user.dart';
import 'package:provider/provider.dart';
import 'package:login_sharedprefernece/providers/user_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  List ulist = [];
  TextEditingController searchtext = TextEditingController();

  void updateUi() {
    setState(() {
      ulist = context.read<UserProvider>().getUser;
    });
  }

  List search(String value) {
    List localList = [];
    localList = context
        .read<UserProvider>()
        .getUser
        .where(((element) => element.name.contains(value)))
        .toList();
    return localList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserProvider>().createUserList();
    updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(
                id: ulist.length + 1,
              ),
            ),
          );
          updateUi();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    ulist = search(value);
                  });
                },
                controller: searchtext,
                decoration: const InputDecoration(
                  hintText: "search... ",
                  contentPadding: EdgeInsets.all(15.0),
                  border: OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: ulist.length,
                    itemBuilder: (context, i) => Column(
                          children: [
                            const Divider(
                              height: 10.0,
                            ),
                            Slidable(
                              key: const ValueKey(1),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                //dismissible: DismissiblePane(onDismissed: () {}),
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title:
                                                    const Text('are you sure'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Yes');
                                                        context
                                                            .read<
                                                                UserProvider>()
                                                            .deleteUser(i);
                                                        updateUi();
                                                      } //upadate the ui
                                                      ,
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'no');
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              ));
                                    },
                                    backgroundColor: Colors.blueGrey,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('Edit User'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 50.0,
                                                      backgroundImage: NetworkImage(
                                                          'https://static.wikia.nocookie.net/b__/images/5/56/Placeholder.gif/revision/latest/scale-to-width-down/300?cb=20130917142741&path-prefix=buffymud'),
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  " Enter Name "),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "required ";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Edit');
                                                      },
                                                      child:
                                                          const Text('Edit')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Cancel');
                                                      },
                                                      child:
                                                          const Text('Cancel'))
                                                ],
                                              ));
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title:
                                                    const Text('are you sure'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Yes');
                                                      } //upadate the ui
                                                      ,
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'no');
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              ));
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.block,
                                    label: 'Block',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: ulist[i]
                                                .userFileImagePath !=
                                            null
                                        //? NetworkImage(ulist[i].Url)
                                        ? FileImage(ulist[i].userFileImagePath)
                                        : ulist[i].url != null
                                            ? NetworkImage(ulist[i].url)
                                            : const AssetImage(
                                                    'images/index.png')
                                                as ImageProvider

                                    ),
                                subtitle: Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    ulist[i].name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
          ],
        ),
      ),
    );
  }
}
