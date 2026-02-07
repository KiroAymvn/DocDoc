import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_text.dart';

class LogoDocdoc extends StatelessWidget {
  const LogoDocdoc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'docdoc-logo',
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/splash_logo.svg"),
            CustomText(
              text: " DOCDOC",
              color: Colors.black,
              size: 30,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
