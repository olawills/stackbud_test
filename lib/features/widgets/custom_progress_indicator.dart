import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color color;
  const CustomProgressIndicator({
    this.color = Colors.red,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: color,
        size: 50.0,
      ),
    );
  }
}
