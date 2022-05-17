import 'dart:math';

import 'package:flutter/material.dart';
import 'package:santa/pages/santa_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/friend.dart';

class FriendsPage extends StatefulWidget {
  static const String routeName = "/friends";

  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String? _groupName;
  final List _friends = <Friend>[];
  final List _colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.grey.shade900,
    Colors.pink,
    Colors.orange,
    Colors.yellow
  ];

  @override
  void initState() {
    super.initState();

    _loadGroupName();
  }

  Future<void> _loadGroupName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final groupName = prefs.getString(groupNameKey);
    setState(() {
      _groupName = groupName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_groupName ?? "Неизвестная группа"),
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: _itemBuilder,
            separatorBuilder: _separatorBuilder,
            itemCount: _friends.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMember,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(15)),
      height: 100,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _friends[index].color)),
          const SizedBox(width: 20),
          Text(
            _friends[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: 10);
  }

  Future<void> _addMember() async {
    final Color randomColor = Random().nextInt(_colors.length).isEven
        ? _colors[Random().nextInt(_colors.length)]
        : _colors[Random().nextInt(_colors.length)];
    final Friend friend =
        Friend(_friends.length.toString(), "Friend", randomColor);
    setState(() {
      _friends.add(friend);
    });
  }
}
