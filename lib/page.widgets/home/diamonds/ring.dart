import 'package:flutter/material.dart';
import 'package:flutter4/page.widgets/home/diamonds/diamonds.page.dart';
import 'package:flutter4/page.widgets/home/diamonds/diamonds.service.dart';

class Ring extends StatelessWidget {	
	final DiamondsPageState parent;

	Ring(this.parent);

	String get ringStatus => DiamondsService.ringStatus;	

	@override 
	Widget build(BuildContext context) {
		String shinkaImg = _getShinkaImg();
		print("ring build");
		
		return Container(
			width: 140,
			height: 100,								
			child: Stack(
				children: <Widget>[
					Center(child: ringStatus != "off" ? Image.asset("assets/img/template/$shinkaImg", width: 80, height: 10) : null),
					Center(
						child: 
							parent.currentDiamond != null ?
								Image.asset("assets/img/stones/${parent.group.name}/${parent.currentDiamond.filename}", height: 10 * parent.currentDiamond.width / 2.5,) :
								null,
					),
					Positioned(
						right: 0, 
						top: 60, 
						child: 
							parent.currentDiamond != null || ringStatus != "off" ?
								Text("\uf0b2", style: TextStyle(fontFamily: "Awesome", fontSize: 16, color: Color.fromRGBO(255, 255, 255, 0.5))) :
								null
					)
				],
			), 
		);
	}

	String _getShinkaImg() {
		String img = "";

		if (ringStatus == "gold") {
			img = "shinka-gold.png";
		} else if (ringStatus == "silver") {
			img = "shinka-silver.png";
		}

		return img;
	}	
}
