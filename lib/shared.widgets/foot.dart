import 'package:flutter/material.dart';
import 'package:flutter4/shared.widgets/menubtn.dart';

class Foot extends StatelessWidget {
	final List<MenuBtn> _buttons = [
		MenuBtn("Home", Icons.home, "/"),
		MenuBtn("Info", Icons.help, "/info"),
	];

	@override
	Widget build(context) {
		return Container(
			height: 70,
			child: DecoratedBox(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(107, 107, 107, 1)],
						begin: Alignment(-1,-1),
						end: Alignment(1,1),						
					),
				),
				child: Row(children: _buttons)
			),
		);
	}
}
