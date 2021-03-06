import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter4/model/diamond.model.dart';
import 'package:flutter4/model/diamondgroup.model.dart';
import 'package:flutter4/page.widgets/home/diamonds/diamonds.page.dart';

class ItemsSlider extends StatefulWidget {
	final DiamondGroup group;
	final DiamondsPageState parent;

	ItemsSlider(this.group, this.parent);

	@override 
	_ItemsSliderState createState() => _ItemsSliderState(group, parent);
}

class _ItemsSliderState extends State {
	final DiamondGroup group;
	final DiamondsPageState parent;
	int _itemWidth = 0;
	int _itemWidthWithPadding = 0;
	double _maxDiamondWidth = 0;	
	ScrollController _scrollController;
	bool _listenNeeded = true;	
	// animations
	double _panelBottom = 0;
	double _panelBtnBottom = -30;

	_ItemsSliderState(this.group, this.parent);

	@override 
	void initState() {		
		_maxDiamondWidth = group.items.map((d) => d.width).reduce(max);
		_scrollController = ScrollController();		
		super.initState();
	}
	
	@override 
	Widget build(BuildContext context) {
		final Size deviceSize = MediaQuery.of(context).size;
		_itemWidth = ((deviceSize.width - 70) / 3).floor();
		_itemWidthWithPadding = _itemWidth - 10;		

		return Stack(
			children: <Widget>[
				// open btn
				AnimatedPositioned(
					bottom: _panelBtnBottom,
					right: 10,
					duration: Duration(milliseconds: 200),
					child: GestureDetector(
						child: Text("\uf077", style: TextStyle(fontFamily: "Awesome", fontSize: 22)),
						onTap: _openPanel,
					),
				),
				// panel
				AnimatedPositioned(
					duration: Duration(milliseconds: 200),
					bottom: _panelBottom,
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
										children: [Expanded(child: Text("Select stone", style: TextStyle(fontSize: 18))),
											GestureDetector(
												child: Text("\uf078", style: TextStyle(fontFamily: "Awesome", fontSize: 22)),
												onTap: _closePanel,
											)
										]
									),
									Divider(),
									// slider
									Expanded(
										child: Row(
											children: <Widget>[
												GestureDetector(
													behavior: HitTestBehavior.opaque, 
													child: Column(children: [Expanded(child: Container(width: 15, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("\uf053", style: TextStyle(fontFamily: "Awesome", fontSize: 18))])))]),
													onTap: _onLeft,
												),
												Container(width: 10),
												Expanded(child: 
													NotificationListener<ScrollNotification>(
														onNotification: _onScrollNotification,
														child: SingleChildScrollView(
															scrollDirection: Axis.horizontal,
															child: Row(children: _getSliderItems()),
															controller: _scrollController,
														),
													),
												),
												Container(width: 10),
												GestureDetector(
													behavior: HitTestBehavior.opaque, 
													child: Column(children: [Expanded(child: Container(width: 15, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("\uf054", style: TextStyle(fontFamily: "Awesome", fontSize: 18))])))]),
													onTap: _onRight,
												)
											]
										)
									)
								]
							)
						)
					)
				)				
			]
		);
	}

	List<Widget> _getSliderItems() {
		List<Widget> widgets = [];

		for (Diamond d in group.items) {
			widgets.add(
				GestureDetector(
					onTap: () => _onDiamondTap(d),
					behavior: HitTestBehavior.opaque, 
					child: Container(
						width: _itemWidth.toDouble(),
						decoration: d.active ? BoxDecoration(border: Border.all(color: Colors.white)) : null,
						child: Padding(
							padding: EdgeInsets.only(left: 5, right: 5),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [							
									Expanded(
										child: Image.asset("assets/img/stones/${group.name}/${d.filename}", width: d.width * _itemWidthWithPadding / _maxDiamondWidth * group.widthCoef),
									),
									Divider(),
									Text(d.size, style: TextStyle(fontSize: 12)),
									Text(d.weight, style: TextStyle(fontSize: 12)),
								],
							)
						)
					)
				)
			);
		}		
		
		return widgets;
	}

	void _onLeft() {
		if (_scrollController.offset > _scrollController.position.minScrollExtent) {
			_scrollController.animateTo(_scrollController.offset - _itemWidth, duration: Duration(milliseconds: 300), curve: Curves.ease);
		}
	}

	void _onRight() {
		if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
			_scrollController.animateTo(_scrollController.offset + _itemWidth, duration: Duration(milliseconds: 300), curve: Curves.ease);
		}
	}

	bool _onScrollNotification(ScrollNotification notification) {
		if (notification is ScrollEndNotification && _listenNeeded) {			
			_onScrollEnd();
		}

		return true;
	}

	void _onScrollEnd() {
		// доводчик
		int offset = 0;
		double misplace = _scrollController.offset % _itemWidth;

		if (misplace > _itemWidth / 2) {
			offset = (_scrollController.offset / _itemWidth).ceil();
		} else {
			offset = (_scrollController.offset / _itemWidth).floor();
		}			
			
		Future.delayed(Duration.zero, () async {
			_listenNeeded = false;
			await _scrollController.animateTo((offset * _itemWidth).toDouble(), duration: Duration(milliseconds: 300), curve: Curves.ease);	
			_listenNeeded = true;
		});	
	}

	void _closePanel() {				
		setState(() {
			_panelBottom = -200;		
		});
		Future.delayed(Duration(milliseconds: 200), () {			
			setState(() {
				_panelBtnBottom = 10;
			});
		});
		parent.onPanelClosed();
	}

	void _openPanel() {		
		setState(() {
			_panelBottom = 0;
			_panelBtnBottom = -30;
		});		
		parent.onPanelOpened();
	}

	void _onDiamondTap(Diamond d) {
		setState(() {
			group.items.forEach((diamond) => diamond.active = false);
			d.active = true;  
			parent.setCurrentDiamond(d);
		});		
	}
}
