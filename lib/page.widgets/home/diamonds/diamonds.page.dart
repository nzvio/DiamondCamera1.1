import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter4/model/diamondgroup.model.dart';
import 'package:flutter4/page.widgets/home/diamonds/itemsslider.dart';
import 'package:flutter4/page.widgets/home/home.page.dart';
import 'package:flutter4/services/diamonds.repository.dart';

class DiamondsPage extends StatefulWidget {
	final HomePageState parent;

	DiamondsPage(this.parent);
	
	@override
	_DiamondsPageState createState() => _DiamondsPageState(parent);	
}

class _DiamondsPageState extends State {
	final HomePageState parent;
	List<CameraDescription> cameras;
	CameraController controller;
	DiamondGroup group;

	_DiamondsPageState(this.parent);
	
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
		cameras = await availableCameras();
		controller = CameraController(cameras[0], ResolutionPreset.medium);
		await controller.initialize();		
	}

	@override 
	Widget build(BuildContext context) {
		bool cameraReady = controller?.value?.isInitialized ?? false;

		if (!cameraReady) {
      		return Text("waiting for camera...");
    	}

		final Size deviceSize = MediaQuery.of(context).size;
		final double deviceRatio = deviceSize.width / deviceSize.height;
		
		return Stack(
			children: <Widget>[
				Transform.scale(
  					scale: controller.value.aspectRatio / deviceRatio,
  					child: Center(
    					child: AspectRatio(
      						aspectRatio: controller.value.aspectRatio,
      						child: CameraPreview(controller),
    					),
  					),
				),
				ItemsSlider(group),
			],
		);
	}
}
