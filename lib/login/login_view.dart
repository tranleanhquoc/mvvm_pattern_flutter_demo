import 'package:flutter/material.dart';
import 'package:mvvm_pattern_flutter_demo/login/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  BodyWidget({Key key}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });
    passController.addListener(() {
      loginViewModel.passSink.add(passController.text);
    });
  }

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: loginViewModel.emailStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "example@gmail.com",
                    labelText: "Email *",
                    errorText: snapshot.data,
                  ),
                );
              }),
          SizedBox(height: 20),
          StreamBuilder<String>(
              stream: loginViewModel.passStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Password *",
                    errorText: snapshot.data,
                  ),
                );
              }),
          SizedBox(height: 40),
          SizedBox(
            width: 200,
            height: 45,
            child: StreamBuilder<bool>(
                stream: loginViewModel.btnStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    onPressed: snapshot.data == true
                        ? () {
                            // call login api
                            print("call login api");
                          }
                        : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
