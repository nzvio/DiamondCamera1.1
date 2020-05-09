import 'package:flutter/material.dart';
import "package:flutter4/extensions/string.extensions.dart";

class Shape extends StatelessWidget {
	final String name;		
	
	Shape(this.name);

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Column(
				children: <Widget>[
					AspectRatio(
						aspectRatio: 0.8, 
						child: Image.asset("assets/img/shapes/$name.png")
					),
					Divider(height: 5),
					Text(name.capitalize()),
				],
			),
			onTap: () {
				print(name);
			},
		);
	}
}