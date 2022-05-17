import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String groupNameKey = "GROUP_NAME";

class SantaHomePage extends StatefulWidget {
  static const String routeName = "/home";

  const SantaHomePage({Key? key}) : super(key: key);

  @override
  State<SantaHomePage> createState() => _SantaHomePageState();
}

class _SantaHomePageState extends State<SantaHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    _controller.addListener(() => print(_controller.text));
  }

  Future<void> _navigatePage({required String routeName}) async {
    Navigator.of(context).pushNamed(routeName);

    if (routeName == "/friends") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(groupNameKey, _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Santa'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Введите название вашей группы"),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Название группы',
                ),
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigatePage(routeName: "/friends");
        },
        tooltip: "Создать вашу группу",
        child: const Icon(Icons.check),
      ),
    );
  }
}
