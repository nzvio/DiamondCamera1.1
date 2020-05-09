import 'package:flutter/material.dart';

import 'package:flutter4/page.widgets/home/home.page.dart';
import 'package:flutter4/page.widgets/home/shape.dart';

class ShapesPage extends StatelessWidget {		
	final HomePageState parent;

	ShapesPage(this.parent);

	@override 
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.all(10),
			child: Column(			
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
							children: [
								Shape("round", parent),
								Shape("oval", parent),
								Shape("cushion", parent),
								Shape("emerald", parent),
								Shape("princess", parent),
								Shape("pearl", parent),	
							],
						)
					),
				],
			)
		);
	}
}
