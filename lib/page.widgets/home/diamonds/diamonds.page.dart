import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:flutter4/model/diamondgroup.model.dart';
import 'package:flutter4/page.widgets/home/diamonds/diamonds.service.dart';
import 'package:flutter4/page.widgets/home/diamonds/itemsslider.dart';
import 'package:flutter4/page.widgets/home/home.page.dart';
import 'package:flutter4/services/diamonds.repository.dart';

class DiamondsPage extends StatefulWidget {
	final HomePageState parent;

	DiamondsPage(this.parent);
	
	@override
	DiamondsPageState createState() => DiamondsPageState(parent);	
}

class DiamondsPageState extends State {
	final HomePageState parent;
	List<CameraDescription> _cameras;
	CameraController _cameraController;
	DiamondGroup group;	
	// animations
	double _screenshotBtnBottom = 210;

	DiamondsPageState(this.parent);

	bool get cameraPower => DiamondsService.cameraPower;
	set cameraPower(bool v) => DiamondsService.cameraPower = v;
	int get currentCamera => DiamondsService.currentCamera;
	set currentCamera(int v) => DiamondsService.currentCamera = v;
	String get ringStatus => DiamondsService.ringStatus;
	set ringStatus(String v) => DiamondsService.ringStatus = v;
	double get ringDX => DiamondsService.ringDX;
	set ringDX(double v) => DiamondsService.ringDX = v;
	double get ringDY => DiamondsService.ringDY;
	set ringDY(double v) => DiamondsService.ringDY = v;
	
	@override
	void initState() {
		super.initState();	
		group = DiamondsRepository.groups.firstWhere((g) => g.name == parent.selectedShapeName);
		_initCamera().then((_) {
			if (mounted) {
				setState(() {}); // refresh state
			}
		});			
	}

	Future<void> _initCamera() async {
		_cameras = await availableCameras();				
		
		if (cameraPower) {
			_cameraController = CameraController(_cameras[currentCamera], ResolutionPreset.medium);
			await _cameraController.initialize();
		}		
	}

	@override
  	void dispose() {
    	_cameraController?.dispose();
    	super.dispose();
  	}

	@override 
	Widget build(BuildContext context) {
		bool cameraReady = _cameraController?.value?.isInitialized ?? false;
		final Size deviceSize = MediaQuery.of(context).size;
		final double deviceRatio = deviceSize.width / deviceSize.height;
		
		return Stack(
			children: <Widget>[
				// camera view
				cameraReady ? 
					Transform.scale(
  						scale: _cameraController.value.aspectRatio / deviceRatio,
  						child: Center(
    						child: AspectRatio(
      							aspectRatio: _cameraController.value.aspectRatio,
      							child: CameraPreview(_cameraController),
    						),
  						),
					) : 
					Container(),
				// slider
				ItemsSlider(group, this),
				// camera power btn
				Positioned(
					left: 10,
					top: 10,
					child: GestureDetector(
						child: Stack(
							children: <Widget>[
								Text("\uf011", style: TextStyle(fontFamily: "Awesome", fontSize: 28)),
								Positioned(
									child: 
										cameraPower ? 
											Text("") :
											Text("\uf00d", style: TextStyle(fontFamily: "Awesome", fontSize: 16, color: Colors.red)),											
									right: 0,
									bottom: 0,
								)
							],
						),
						onTap: _toggleCameraPower
					)
				),
				// camera switch btn
				Positioned(
					left: 10,
					top: 60,
					child: 
						cameraReady && cameraPower && _cameras.length > 1 ? 
							GestureDetector(
								child: Text("\uf2f1", style: TextStyle(fontFamily: "Awesome", fontSize: 28)),
								onTap: _switchCamera,
							) :
							Container(),
				),
				// ring mode btn
				Positioned(
					right: 10,
					top: 10,
					child: GestureDetector(
						child: Stack(
							children: <Widget>[
								Text("\uf70b", style: TextStyle(fontFamily: "Awesome", fontSize: 28, color: ringStatus == "gold" ? Color.fromRGBO(231, 180, 63, 1) : Color.fromRGBO(255, 255, 255, 1))),
								Positioned(
									child: 
										ringStatus == "off" ? 
											Text("\uf00d", style: TextStyle(fontFamily: "Awesome", fontSize: 16, color: Colors.red)) :
											Text(""),											
									right: 0,
									bottom: 0,
								),
							],
						), 
						onTap: _toggleRing,
					)
				),
				// screenshot btn
				AnimatedPositioned(
					duration: Duration(milliseconds: 200),
					left: 0,
					bottom: _screenshotBtnBottom,
					right: 0,
					child: GestureDetector(
						child: Center(child: Text("\uf030", style: TextStyle(fontFamily: "Awesome", fontSize: 32))),
					)
				),
				// ring
				AnimatedPositioned(
					duration: Duration(milliseconds: 0),
					left: deviceSize.width / 2 - 70 + ringDX,
					top: 150 + ringDY,
					child: GestureDetector(
						child: _getRing(),
						behavior: HitTestBehavior.opaque, 						
						onPanUpdate: _onRingDrag,						
					),
				),
			],
		);
	}

	void onPanelClosed() {
		Future.delayed(Duration(milliseconds: 500), () {			
			setState(() {
				_screenshotBtnBottom = 10;
			});
		});
	}

	void onPanelOpened() {
		setState(() {
			_screenshotBtnBottom = 210;
		});
	}

	void _toggleCameraPower() {
		if (cameraPower) {
			setState(() {
				_cameraController.dispose();
				cameraPower = false;  
			});			
		} else {
			setState(() {
				_cameraController = CameraController(_cameras[currentCamera], ResolutionPreset.medium);
				_cameraController.initialize();
				cameraPower = true;			  
			});			
		}
	}

	void _switchCamera() async {
		currentCamera = currentCamera == 0 ? 1 : 0;
		await _cameraController.dispose();
		_cameraController = CameraController(_cameras[currentCamera], ResolutionPreset.medium);
		await _cameraController.initialize();
		setState(() {});
	}

	Widget _getRing() {
		if (ringStatus == "off") {
			return Container();
		} else {
			String img = ringStatus == "gold" ? "shinka-gold.png" : "shinka-silver.png";
			return Column(children: <Widget>[
				Container(
					width: 140,					
					child: Center(
						child: Image.asset("assets/img/template/$img", width: 80, height: 10)
					),
				),
				Container(
					width: 140,
					alignment: Alignment.bottomRight,
					child: Text("\uf0b2", style: TextStyle(fontFamily: "Awesome", fontSize: 16, color: Color.fromRGBO(255, 255, 255, 0.5))),
				),
			]);
		}		
	}

	void _toggleRing() {
		setState(() {
			if (ringStatus == 'off') {
				ringStatus = "gold";
			} else if (ringStatus == "gold") {
				ringStatus = "silver";
			} else if (ringStatus == "silver") {
				ringStatus = "off";
			}
		});		
	}
	
	void _onRingDrag(DragUpdateDetails event) {
		setState(() {
			ringDX += event.delta.dx;  
			ringDY += event.delta.dy;  
		});		
	}	
}
