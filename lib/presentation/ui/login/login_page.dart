import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/common/util/shared_preferences.dart';
import 'package:indoxx1/common/util/shared_preferences_key.dart';
import 'package:indoxx1/presentation/bloc/event/user_event.dart';
import 'package:indoxx1/presentation/bloc/state/user_state.dart';
import 'package:indoxx1/presentation/bloc/user_bloc.dart';
import 'package:indoxx1/routes/application.dart';
import 'package:indoxx1/routes/routes.dart';

final UserBloc userBloc = UserBloc();

class LoginPage extends StatefulWidget {
  @override
  _LoginStatePage createState() => _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {
  FocusNode _tokenFocusNode = new FocusNode();

  bool _isShowToken = false;
  final tokenController = TextEditingController();

  void _showToken() {
    setState(() {
      if (!this._isShowToken) {
        this._isShowToken = true;
      } else {
        this._isShowToken = false;
      }
    });
  }

  void _doLogin(BuildContext context) {
    String tokenId = tokenController.text;
    if (tokenId.trim() == '') {
      SnackBar snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        content: Text('Please fill the token'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      userBloc.add(UserFetchEvent(tokenId: tokenId));
    }
  }

  void _listen(BuildContext context, state) {
    if (state is UserLoadedState) {
      if (state.res != null && state.res != "") {
        SpUtil.getInstance().then(
            (sp) {
          sp.putString(SharedPreferencesKeys.name, state.res.name); 
          sp.putString(SharedPreferencesKeys.email, state.res.email);
          sp.putString(SharedPreferencesKeys.tokenId, state.res.tokenId);   
        });
        Application.router.navigateTo(context, Routes.home,
            transition: TransitionType.native);
      } else {
        SnackBar snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          content: Text('You have not registered'),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
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
                        icon: Icon(Icons.remove_red_eye, color: Colors.black),
                        onPressed: this._showToken),
                  ),
                  obscureText: !this._isShowToken,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Token can't be empty";
                    }
                    return null;
                  },
                  controller: tokenController,
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

  Widget _buildSignInButton(BuildContext context) {
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
        this._doLogin(context);
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
        Application.router.navigateTo(context, Routes.addUser,
            transition: TransitionType.native);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        bloc: userBloc,
        listener: (context, state) {
          _listen(context, state);
        },
        child: Builder(
          builder: (context) => SingleChildScrollView(
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
                              this._buildSignInButton(context),
                              SizedBox(
                                width: 20.0,
                              ),
                              this._buildSignUpButton(context),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }
}
