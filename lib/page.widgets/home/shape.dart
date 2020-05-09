import 'package:flutter/material.dart';

import "package:flutter4/extensions/string.extensions.dart";
import 'package:flutter4/page.widgets/home/home.page.dart';

class Shape extends StatelessWidget {
	final String name;		
	final HomePageState parent;
	
	Shape(this.name, this.parent);

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
				parent.changeState(mode: "diamonds", selectedShapeName: name);
			},
		);
	}
}