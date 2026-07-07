import 'package:exam_app/core/constant/app_icons.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
 
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  CustomAppBar({super.key, required this.title});
  final String title ;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late AppColors colors;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(AppIcons.arrowBack, color: colors.black, size: 25.w),
            SizedBox(width: 10.w),
            Text(
              widget.title,
              style: TextStyle(
                color: colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    
  }
}