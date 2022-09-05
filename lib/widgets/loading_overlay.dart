import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget _child;
  final LoadingOverlayController _controller;
  LoadingOverlay(
      {required Widget child, LoadingOverlayController? controller, Key? key})
      : _child = child,
        _controller = controller ?? LoadingOverlayController(),
        super(
          key: key,
        );

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class LoadingOverlayController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LoadingOverlayController();

  void showLoadingOverlay() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoadingOverlay() {
    _isLoading = false;
    notifyListeners();
  }
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  void initState() {
    widget._controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget._child,
        if (widget._controller.isLoading)
          Container(
            color: const Color.fromARGB(166, 0, 0, 0),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
