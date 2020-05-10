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
	List<CameraDescription> _cameras;
	CameraController _cameraController;
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
		_cameras = await availableCameras();
		_cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
		await _cameraController.initialize();		
	}

	@override
  	void dispose() {
    	_cameraController?.dispose();
    	super.dispose();
  	}

	@override 
	Widget build(BuildContext context) {
		bool cameraReady = _cameraController?.value?.isInitialized ?? false;

		if (!cameraReady) {
      		return Text("waiting for camera...");
    	}

		final Size deviceSize = MediaQuery.of(context).size;
		final double deviceRatio = deviceSize.width / deviceSize.height;
		
		return Stack(
			children: <Widget>[
				Transform.scale(
  					scale: _cameraController.value.aspectRatio / deviceRatio,
  					child: Center(
    					child: AspectRatio(
      						aspectRatio: _cameraController.value.aspectRatio,
      						child: CameraPreview(_cameraController),
    					),
  					),
				),
				ItemsSlider(group),
			],
		);
	}
}
