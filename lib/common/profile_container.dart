import 'package:flutter/material.dart';

class GradientBorderProfile extends StatelessWidget {
  final String imageUrl;

  const GradientBorderProfile({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3), // Border width
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xffD933EF),
            Color(0xff5B84EA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Optional inner background
        ),
        padding: const EdgeInsets.all(2), // Optional inner spacing
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl), // Or use AssetImage
        ),
      ),
    );
  }
}
