import 'package:flutter/material.dart';

class Foot extends StatelessWidget {
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
				child: Row(					
					children: [
						Expanded(
							child: GestureDetector(
								child: DecoratedBox(
									decoration: BoxDecoration(color: Colors.indigo),
									child: Column(
										children: [
											Icon(Icons.home),
											Text("Home"),
										],
										mainAxisAlignment: MainAxisAlignment.center
									)
								),
								onTap: () {
									print("test");
								},
							), 
						),
						Expanded(
							child: GestureDetector(
								child: DecoratedBox(
									decoration: BoxDecoration(color: Colors.red),
									child: Column(
										children: [
											Icon(Icons.help),
											Text("Info"),
										],
										mainAxisAlignment: MainAxisAlignment.center
									)
								),
								onTap: () {
									print("test2");
								},
							), 
						),
					]
				)
			),
		);
	}
}
