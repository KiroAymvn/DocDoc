import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';

class CustomRememberForgotWidget extends StatelessWidget {
  const CustomRememberForgotWidget({super.key, required ValueNotifier<bool> val}) : _val = val;

  final ValueNotifier<bool> _val;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: _val,
          builder: (context, value, child) {
            return Checkbox(
              value: _val.value,
              onChanged: (v) {
                _val.value = !_val.value;
              },
              activeColor: AppColors.kPrimary,
            );
          },
        ),
        CustomText(text: "Remember me ", color: AppColors.kGrey, size: 15),
      ],
    );
  }
}
