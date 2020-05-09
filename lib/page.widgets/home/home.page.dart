import 'package:flutter/material.dart';

import 'package:flutter4/page.widgets/home/diamonds/diamonds.page.dart';
import 'package:flutter4/page.widgets/home/shapes/shapes.page.dart';

class HomePage extends StatefulWidget {
	@override
	HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {	
	String _mode = "shapes";
	String _selectedShapeName = "";
	
	@override 
	void initState() {
        super.initState();
		_mode = "shapes";
		_selectedShapeName = "";
  	}

	@override 
	Widget build(BuildContext context) {
		return _mode == "shapes" ? ShapesPage(this) : DiamondsPage();
	}	

	void changeState({String mode, String selectedShapeName}) {
		setState(() {
			_mode = mode;
			_selectedShapeName = selectedShapeName;
		});
	}
}