import 'package:flutter/material.dart';
import 'package:votesmarter/screen/main_game.dart';
import 'package:votesmarter/state/game_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: RaisedButton(
        onPressed: () {
          final GameState state = new GameState();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainGame(state: state)));
        },
        padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          'Start Game',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}
