import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app/app_color.dart';
import '../core/extensions/index.dart';

typedef FnCallBack = void Function();

class MainButton extends StatelessWidget {
  final String textName;
  final Color? bgColor;
  final Color? textColor;
  final FnCallBack? onTap;
  final double? height;
  final double? width;
  final double? radius;
  final Widget? preIcon;
  final bool collapseInput;
  final double? fontSize;

  const MainButton({
    super.key,
    required this.textName,
    this.preIcon,
    this.bgColor,
    this.onTap,
    this.textColor,
    this.height,
    this.width,
    this.collapseInput = true,
    this.radius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = bgColor ?? Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height ?? 40.w,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: backgroundColor,
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.w),
          ),
        ),
        onPressed: onTap == null
            ? null
            : () {
                if (collapseInput) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                onTap?.call();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            preIcon != null ? preIcon!.pr(8.w) : const SizedBox(),
            Text(
              textName,
              style: TextStyle(
                color: onTap == null
                    ? AppColor.textGrey
                    : textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontSize: fontSize ?? 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
