import 'package:flutter/material.dart';
import 'package:flutter4/pages/home/shape.dart';

class HomePage extends StatelessWidget {
	final List<Shape> _shapes = [
		Shape("round"),
		Shape("oval"),
		Shape("cushion"),
		Shape("emerald"),
		Shape("princess"),
		Shape("pearl"),		
	];
	
	@override 
	Widget build(BuildContext context) {
		return Column(			
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[			
				Text("SELECT SHAPE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
				Divider(),
				Expanded(
					child: GridView.count(
						crossAxisCount: 3,						
						mainAxisSpacing: 15,
						crossAxisSpacing: 15,
						childAspectRatio: 0.65,						
						children: _shapes,
					)
				),
			],
		);
	}
}
