import 'package:flutter/material.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_colors.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_dimens.dart';

class CreatePostFab extends StatelessWidget {
  const CreatePostFab({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppDimens.isTablet(context)) {
      return FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'Publier',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      );
    }

    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      child: const Icon(Icons.add, size: 28),
    );
  }
}
