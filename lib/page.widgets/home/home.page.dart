import 'package:flutter/material.dart';

import 'package:flutter4/page.widgets/home/diamonds/diamonds.page.dart';
import 'package:flutter4/page.widgets/home/shapes/shapes.page.dart';

class HomePage extends StatefulWidget {
	HomePageState state;
	
	@override
	HomePageState createState() => state = HomePageState();
}

class HomePageState extends State<HomePage> {	
	String mode = "shapes";
	String selectedShapeName = "";
	
	@override 
	void initState() {
        super.initState();
		mode = "shapes";
		selectedShapeName = "";
  	}

	@override 
	Widget build(BuildContext context) {
		return mode == "shapes" ? ShapesPage(this) : DiamondsPage(this);
	}	

	void changeState({String mode, String selectedShapeName}) {
		setState(() {
			this.mode = mode;
			this.selectedShapeName = selectedShapeName;
		});
	}
}