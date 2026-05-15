/// User Avatar Component
/// Avatar elegante com status online opcional

import 'package:flutter/material.dart';
import '../design_system/colors.dart';

enum AvatarSize { xs, sm, md, lg, xl }

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  final String? initials;
  final AvatarSize size;
  final bool isOnline;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const UserAvatar({
    required this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.isOnline = false,
    this.backgroundColor,
    this.onTap,
    Key? key,
  }) : super(key: key);

  double get _radius {
    switch (size) {
      case AvatarSize.xs:
        return 16;
      case AvatarSize.sm:
        return 20;
      case AvatarSize.md:
        return 28;
      case AvatarSize.lg:
        return 40;
      case AvatarSize.xl:
        return 56;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: _radius,
            backgroundColor:
                backgroundColor ?? const Color(0xFFE5E7EB),
            backgroundImage: NetworkImage(imageUrl),
            child: initials != null
                ? Text(
                    initials!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _radius * 0.6,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: _radius * 0.5,
                height: _radius * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
