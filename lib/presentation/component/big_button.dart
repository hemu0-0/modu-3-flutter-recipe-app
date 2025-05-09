import 'package:flutter/material.dart';

import '../../ui/color_styles.dart';
import '../../ui/text_styles.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final bool isEnabled;

  const BigButton({
    super.key,
    required this.text,
    this.onClick,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onClick : null,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorStyles.primary100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyles.normalBold.copyWith(color: ColorStyles.white),
              ),
              SizedBox(width: 20),
              Icon(Icons.arrow_forward, color: ColorStyles.white),
            ],
          ),
        ),
      ),
    );
  }
}
