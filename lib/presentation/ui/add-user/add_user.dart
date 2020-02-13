import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/presentation/bloc/event/user_event.dart';
import 'package:indoxx1/presentation/bloc/state/user_state.dart';
import 'package:indoxx1/presentation/bloc/user_bloc.dart';
import 'package:indoxx1/routes/application.dart';
import 'package:indoxx1/routes/routes.dart';

final UserBloc userBloc = UserBloc();

class AddUserPage extends StatefulWidget {

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  bool _isShowToken = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();

  void _showToken() {
    setState(() {
      if (!this._isShowToken) {
        this._isShowToken = true;
      } else {
        this._isShowToken = false;
      }
    });
  }

  void _doSignUp(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;
    String token = _tokenController.text;

    if (name.trim() == '' || email.trim() == '' || token.trim() == '') {
      SnackBar snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        content: Text('Please fill the token'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      userBloc.add(UserAddNewEvent(name: name, email: email, tokenId: token));
    }
  }

  void _listen(BuildContext context, state) {
    if (state is UserAddNewState) {
      if (state.res != null && state.res != "Success") {
        Application.router.navigateTo(context, Routes.login,
            transition: TransitionType.native);
      } else {
        SnackBar snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(state.res),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget _buildInputTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 190,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: "Name",
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "Email",
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenTextForm() {
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
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Token",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye, color: Colors.black),
                        onPressed: this._showToken),
                  ),
                  obscureText: !this._isShowToken,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  controller: _tokenController,
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

  Widget _buildSignUPButton(BuildContext context) {
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
          "SIGN UP",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        this._doSignUp(context);
      },
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.blueGrey,
        ),
        child: Text(
          "CANCEL",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
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
                          this._buildInputTextForm(),
                          this._buildTokenTextForm(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              this._buildSignUPButton(context),
                              SizedBox(
                                width: 20.0,
                              ),
                              this._buildCancelButton(context),
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
    super.dispose();
  }
}