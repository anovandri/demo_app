import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/home/home_page.dart';
import 'package:indoxx1/routes/application.dart';
import 'package:indoxx1/routes/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginStatePage createState() => _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {
  FocusNode _tokenFocusNode = new FocusNode();

  bool _isShowToken = false;
  String _token = "";

  void _showToken() {
    setState(() {
       if (!this._isShowToken) {
         this._isShowToken = true;
       } else {
         this._isShowToken = false;
       }
    });
  }

  void _doLogin() {
    Application.router.navigateTo(context, Routes.home, transition: TransitionType.native);
  }

  Widget _buildSignInTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 110,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: TextFormField(
                  focusNode: _tokenFocusNode,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Enter Token",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye, 
                        color: Colors.black
                      ), 
                      onPressed: this._showToken
                    ),
                  ),
                  obscureText: !this._isShowToken,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Token can't be empty";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      this._token = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          "SIGN IN",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        this._doLogin();
      },
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(
          left: 20, 
          right: 20, 
          top: 10, 
          bottom: 10
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.blueGrey,
        ),
        child: Text(
          "SIGN UP",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                            width: 80.0,
                            height: 80.0,
                          )
                        ],
                      ),
                      this._buildSignInTextForm(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          this._buildSignInButton(),
                          SizedBox(
                            width: 20.0,
                          ),
                          this._buildSignUpButton(),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
