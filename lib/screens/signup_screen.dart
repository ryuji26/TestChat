import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_chat_app/resources/auth_methods.dart';
import 'package:test_chat_app/screens/room_list_screen.dart';
import 'package:test_chat_app/screens/login_screen.dart';
import 'package:test_chat_app/utils/utils.dart';
import 'package:test_chat_app/widget/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  // ユーザー登録のメソッド
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // authmethodsを使ってユーザー登録
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );
    // successが返された場合、ユーザー登録が成功
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // HomeScreenに移動
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RoomListScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // エラーの表示
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png'),
                        ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'ユーザーネーム',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'メールアドレス',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'パスワード',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                          '登録する',
                        )
                      : const CircularProgressIndicator(
                          // color: primaryColor,
                          ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    // color: blueColor,
                  ),
                ),
                onTap: signUpUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      '既にアカウントをお持ちですか？',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' ログイン',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
