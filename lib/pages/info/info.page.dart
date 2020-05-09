import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';

class InfoPage extends StatelessWidget {
	@override 
	Widget build(BuildContext context) {
		return ListView(
			children: <Widget>[
				Text("PROGRAM FOR CALCULATING PRECIOUS METALS FROM A HIGHER SAMPLE TO LOWER VALUES OF GOLD AND SILVER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
				Divider(),
				FutureBuilder(
					future: rootBundle.loadString("assets/html/info1.html"),
					initialData: "loading...",
					builder: (context, snapshot) {
						return Html(data: snapshot.data ?? "");
					}
				),
				Align(
					alignment: Alignment.topLeft,
					child: FractionallySizedBox(
						widthFactor: 0.5,										
						child: Image.asset("assets/img/template/hystlogo.png"),					
					),
				),
				FutureBuilder(
					future: rootBundle.loadString("assets/html/info2.html"),
					initialData: "loading...",
					builder: (context, snapshot) {
						return Html(data: snapshot.data ?? "");
					}
				),
			],
		);
	}
}