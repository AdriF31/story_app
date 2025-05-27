import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

class DevBannerOverlay extends StatelessWidget {
  final Widget child;

  const DevBannerOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return child;

    return Stack(
      children: [
        child,
        Positioned(
          top: 30,
          right: 10,
          child: GestureDetector(
            onTap: () {

                ChuckerFlutter.showChuckerScreen();

            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DEV',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
