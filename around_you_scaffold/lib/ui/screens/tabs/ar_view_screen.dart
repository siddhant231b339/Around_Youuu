import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class ARViewScreen extends StatefulWidget {
  const ARViewScreen({super.key});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  ARSessionManager? _arSessionManager;
  ARObjectManager? _arObjectManager;
  ARPlaneManager? _arPlaneManager;

  bool _ready = false;
  ARNode? _placedNode;

  @override
  void dispose() {
    _arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelUrl = dotenv.env['AR_TEST_GLB_URL'] ?? '';
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ARView(
          onARViewCreated: (c) async {
            _arSessionManager = c.arSessionManager;
            _arObjectManager = c.arObjectManager;
            _arPlaneManager = c.arPlaneManager;

            await _arSessionManager?.setupPlaneDetection(
              horizontalPlane: true,
              verticalPlane: false,
              enableClassification: false,
            );
            await _arObjectManager?.setup();

            setState(() => _ready = true);
          },
          planeDetectionConfig: PlaneDetectionConfig.horizontal,
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 24,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _placedNode == null ? 'Scan for a surface and place the model' : 'Model placed. Tap again to move.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: (!_ready || modelUrl.isEmpty)
                        ? null
                        : () async {
                            if (_placedNode != null) {
                              await _arObjectManager?.removeNode(_placedNode!);
                              _placedNode = null;
                            }
                            final node = ARNode(
                              type: NodeType.webGLB,
                              uri: modelUrl,
                              scale: Vector3(0.4, 0.4, 0.4),
                            );
                            await _arObjectManager?.addNode(node);
                            _placedNode = node;
                            setState(() {});
                          },
                    icon: const Icon(Icons.place),
                    label: const Text('Place Model'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}