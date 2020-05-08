import 'package:flutter/material.dart';

class Head extends StatelessWidget implements PreferredSizeWidget {	
	@override 
	Widget build(BuildContext context) {
		return AppBar(
			title: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Container(
						child: Text("\uf3a5", style: TextStyle(fontSize: 14, fontFamily: "Awesome")),
						margin: EdgeInsets.only(right: 5),
					),
					Text("Diamond Camera", style: TextStyle(fontSize: 14)),
				],
			),
			centerTitle: true,
			flexibleSpace: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(107, 107, 107, 1)],
						begin: Alignment(-1,-1),
						end: Alignment(1,1),						
					),
				),
			),
		);
	}

	@override
  	Size get preferredSize => new Size.fromHeight(40);
}
