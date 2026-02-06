import 'dart:ui';

import 'package:dating_app/models/nearby_user_model.dart';
import 'package:dating_app/utils/screen_size.dart';
import 'package:flutter/material.dart';

class _FriendCard extends StatelessWidget {
  final NearbyUser user;

  const _FriendCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SizeConfig.init(context);

    final displayName =
        (user.nickname.isNotEmpty ? user.nickname : user.name);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockHeight * 1.5,
        horizontal: SizeConfig.blockWidth * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.25),
            theme.colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          ClipOval(
            child: user.profileImage.isNotEmpty
                ? Image.network(
                    user.profileImage,
                    height: SizeConfig.blockWidth * 12,
                    width: SizeConfig.blockWidth * 12,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/girlimage3.png',
                        height: SizeConfig.blockWidth * 12,
                        width: SizeConfig.blockWidth * 12,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/girlimage3.png',
                    height: SizeConfig.blockWidth * 12,
                    width: SizeConfig.blockWidth * 12,
                    fit: BoxFit.cover,
                  ),
          ),

          SizedBox(height: SizeConfig.blockHeight * 1),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 2,
              vertical: SizeConfig.blockHeight * 0.5,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.language.isNotEmpty ? user.language : 'Unknown',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 2.8,
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: SizeConfig.blockHeight * 0.5),

          Text(
            displayName.isNotEmpty ? displayName : 'name',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 3.2,
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),

          SizedBox(height: SizeConfig.blockHeight * 1),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 3,
              vertical: SizeConfig.blockHeight * 0.8,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.phone,
                  color: theme.colorScheme.onPrimary,
                  size: SizeConfig.blockWidth * 2.8,
                ),
                SizedBox(width: SizeConfig.blockWidth * 1),
                Text(
                  'Call Now',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: SizeConfig.blockWidth * 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
