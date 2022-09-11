import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class AddRoomScreen extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddRoomScreen> {
  final TextEditingController _chatroomTitleController =
      TextEditingController();

  bool isLoading = false;

  void createRoom() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadRoom(
        _chatroomTitleController.text,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          '作成しました',
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chatroomTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ルーム作成'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _chatroomTitleController,
                decoration: const InputDecoration(
                    hintText: "ルーム名", border: InputBorder.none),
                maxLines: 3,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      createRoom();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "作成する",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
