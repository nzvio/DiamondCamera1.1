import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DiamondsPage extends StatefulWidget {
	@override
	_DiamondsPageState createState() => _DiamondsPageState();	
}

class _DiamondsPageState extends State {
	List<CameraDescription> cameras;
	CameraController controller;	
	
	@override
	void initState() {
		super.initState();		
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
				Positioned(
					bottom: 0,
					left: 0,
					right: 0,
					child: Container(
						color: Color.fromRGBO(0, 0, 0, 0.5),
						height: 200,
					),
				),				
			],
		);
	}
}
