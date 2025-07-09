import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({this.progressExample = false});
  final bool progressExample;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  late PDFDocument document;

  final TransformationController _transformationController =
      TransformationController();
  final double _minScale = 1.0;
  final double _maxScale = 3.0;

  final PageController _pageController = PageController();

  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  void _zoomIn() {
    setState(() {
      final currentScale = _transformationController.value.getMaxScaleOnAxis();
      _currentScale = (currentScale + 0.1).clamp(_minScale, _maxScale);
      _transformationController.value = Matrix4.identity()
        ..scale(_currentScale);
    });
  }

  void _zoomOut() {
    setState(() {
      final currentScale = _transformationController.value.getMaxScaleOnAxis();
      _currentScale = (currentScale - 0.1).clamp(_minScale, _maxScale);
      _transformationController.value = Matrix4.identity()
        ..scale(_currentScale);
    });
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
      "https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf",
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isZoomed = _currentScale != 1.0;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PDFViewer')),
        body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    InteractiveViewer(
                      transformationController: _transformationController,
                      panEnabled: true,
                      minScale: _minScale,
                      maxScale: _maxScale,
                      child: IgnorePointer(
                        ignoring: isZoomed,
                        child: PDFViewer(
                          document: document,
                          maxScale: 1.0,
                          minScale: 1.0,
                          lazyLoad: true,
                          zoomSteps: 0,
                          showPicker: false,
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          showNavigation: false,
                          onPageChanged: (page) {},
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            heroTag: 'zoomIn',
                            mini: true,
                            onPressed: _zoomIn,
                            child: const Icon(Icons.zoom_in),
                          ),
                          const SizedBox(height: 10),
                          FloatingActionButton(
                            heroTag: 'zoomOut',
                            mini: true,
                            onPressed: _zoomOut,
                            child: const Icon(Icons.zoom_out),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
