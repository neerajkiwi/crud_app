import 'package:flutter/cupertino.dart';
import 'package:login_sharedprefernece/user.dart';

class UserProvider extends ChangeNotifier {
  String? name;
  String? url;

  final List _dummyData = [
    {
      "id": 1,
      "name": 'aman',
      "url":
          "https://media.istockphoto.com/photos/75mpix-panorama-of-beautiful-mount-ama-dablam-in-himalayas-nepal-picture-id1341288649?s=612x612",
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 2,
      "name": 'badri',
      "url":
          'https://media.istockphoto.com/photos/wild-grass-in-the-mountains-at-sunset-picture-id1322277517?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 3,
      "name": 'chetan',
      "url":
          'https://media.istockphoto.com/photos/snowy-peaks-of-the-caucasus-mountains-picture-id1327243304?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 4,
      "name": 'darshan',
      "url":
          'https://media.istockphoto.com/photos/morning-fog-over-a-beautiful-lake-surrounded-by-pine-forest-stock-picture-id1306075353?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 5,
      "name": 'enum',
      "url":
          'https://media.istockphoto.com/photos/aerial-view-of-lake-tahoe-shoreline-with-mountains-and-turquoise-blue-picture-id1302742624?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 6,
      "name": 'farhan',
      "url":
          'https://media.istockphoto.com/photos/milky-way-over-snowy-mountains-and-lake-at-night-landscape-with-snow-picture-id1328564799?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 7,
      "name": 'gopal',
      "url":
          'https://media.istockphoto.com/photos/milky-way-over-snowy-mountains-and-lake-at-night-landscape-with-snow-picture-id1328564799?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 8,
      "name": 'harish',
      "url":
          'https://media.istockphoto.com/photos/brecon-beacons-landscape-picture-id1308867983?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 9,
      "name": 'ibola',
      "url":
          'https://media.istockphoto.com/photos/various-views-of-guru-shikhar-mt-abu-picture-id1303025227?s=612x612',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 10,
      "name": 'jackson',
      "url":
          'https://images.unsplash.com/photo-1589182373726-e4f658ab50f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      "userFileImagePath": null,
      "isBlocked": false,
    },
    {
      "id": 11,
      "name": 'kapil',
      "url":
          "https://images.unsplash.com/photo-1504870712357-65ea720d6078?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
      "userFileImagePath": null,
      "isBlocked": false,
    },
  ];

  final List<User> _users = [];

  void createUserList() {
    for (var userdata in _dummyData) {
      _users.add(User(
          id: userdata['id'],
          name: userdata['name'],
          url: userdata['url'],
          userFileImagePath: userdata['userFileImagePath'],
          isBlocked: userdata['isBlocked']));
    }
  }

  List get getUser => List.unmodifiable(_users);

  void deleteUser(int i) {
    _users.removeAt(i);
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }
}
