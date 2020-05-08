import 'package:flutter/material.dart';

class Shape extends StatelessWidget {
	final String name;
	final String img;

	Shape(this.name, this.img);

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				AspectRatio(
					aspectRatio: 0.8, 
					child: Image.asset("assets/img/shapes/$img")
				),
				Divider(height: 5),
				Text(name),
			],
		);
	}
}