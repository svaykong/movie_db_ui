import 'package:flutter/material.dart';
import 'package:movieui_design_starter/utils/colors.dart';

class CustomCardThumbnail extends StatelessWidget {
  const CustomCardThumbnail({
    super.key,
    required this.imgAsset,
  });

  final String imgAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kButtonColor.withOpacity(0.25),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imgAsset),
          fit: BoxFit.cover,
        ),
      ),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 20.0,
        bottom: 30.0,
      ),
    );
  }
}
