import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter4/model/diamond.model.dart';
import 'package:flutter4/model/diamondgroup.model.dart';

class ItemsSlider extends StatefulWidget {
	final DiamondGroup group;

	ItemsSlider(this.group);

	@override 
	_ItemsSliderState createState() => _ItemsSliderState(group);
}

class _ItemsSliderState extends State {
	final DiamondGroup group;
	double _itemWidth = 0;
	double _itemWidthWithPadding = 0;
	double _maxItemWidth = 0;	

	_ItemsSliderState(this.group);

	@override 
	void initState() {		
		_maxItemWidth = group.items.map((d) => d.width).reduce(max);
		super.initState();
	}
	
	@override 
	Widget build(BuildContext context) {
		final Size deviceSize = MediaQuery.of(context).size;
		_itemWidth = (deviceSize.width - 70) / 3;
		_itemWidthWithPadding = _itemWidth - 10;		

		return Positioned(
			bottom: 0,
			left: 0,
			right: 0,
			child: Container(
				color: Color.fromRGBO(0, 0, 0, 0.5),
				height: 200,
				child: Padding(
					padding:  EdgeInsets.all(10),
					child: Column(
						children: <Widget>[
							// title
							Row(
								children: [
									Expanded(child: Text("Select stone", style: TextStyle(fontSize: 18))),
									Text("\uf078", style: TextStyle(fontFamily: "Awesome", fontSize: 18))
								]
							),							
							Divider(),
							// slider
							Expanded(
								child: Row(
									children: <Widget>[
										Container(
											width: 15,
											child: Text("\uf053", style: TextStyle(fontFamily: "Awesome", fontSize: 18)),
										),
										Container(width: 10),
										Expanded(child: 
											SingleChildScrollView(
												scrollDirection: Axis.horizontal,
												child: Row(children: _buildSliderItems()),
											)
										),
										Container(width: 10),
										Container(
											width: 15,
											alignment: Alignment.centerRight,
											child: Text("\uf054", style: TextStyle(fontFamily: "Awesome", fontSize: 18)),
										),
									],
								)
							)
						]
					),
				)
			),
		);
	}

	List<Widget> _buildSliderItems() {
		List<Widget> widgets = [];

		for (Diamond d in group.items) {
			widgets.add(
				Container(
					width: _itemWidth,
					child: Padding(
						padding: EdgeInsets.only(left: 5, right: 5),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [							
								Expanded(
									child: Image.asset("assets/img/stones/${group.name}/${d.filename}", width: d.width * _itemWidthWithPadding / _maxItemWidth * group.widthCoef),
								),
								Divider(),
								Text(d.size, style: TextStyle(fontSize: 12)),
								Text(d.weight, style: TextStyle(fontSize: 12)),
							],
						)
					)
				)
			);
		}		
		
		return widgets;
	}
}
