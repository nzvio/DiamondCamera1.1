import 'package:flutter/material.dart';

import "package:flutter4/extensions/string.extension.dart";
import 'package:flutter4/model/diamondgroup.model.dart';
import 'package:flutter4/page.widgets/home/home.page.dart';

class Shape extends StatelessWidget {
	final DiamondGroup group;
	final HomePageState parent;
	
	Shape(this.group, this.parent);

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Column(
				children: <Widget>[
					AspectRatio(
						aspectRatio: 0.8, 
						child: Image.asset("assets/img/shapes/${group.img}")
					),
					Divider(height: 5),
					Text(group.name.capitalize()),
				],
			),
			onTap: () {				
				parent.changeState(mode: "diamonds", selectedShapeName: group.name);				
			},
		);
	}
}