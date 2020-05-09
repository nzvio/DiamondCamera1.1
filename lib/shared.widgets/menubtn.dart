import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {	
	final String _name;
	final IconData _icon;
	final String _url;

	MenuBtn(this._name, this._icon, this._url);
	
	@override 
	Widget build(context) {
		return Expanded(
			child: GestureDetector(
				child: DecoratedBox(
					decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, _isActive(context) ? 1 : 0)),
					child: Column(
						children: [
							Icon(_icon, color: Colors.white),
							Text(_name),
						],
						mainAxisAlignment: MainAxisAlignment.center
					)
				),
				onTap: () => _onTap(context)				
			), 
		);
	}

	bool _isActive(context) {
		return ModalRoute.of(context).settings.name == _url;
	}

	void _onTap(BuildContext context) {
		if (!_isActive(context)) {
			Navigator.pushNamed(context, _url);
		}					
	}
}
