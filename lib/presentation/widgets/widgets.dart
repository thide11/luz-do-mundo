import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/theme/app_colors.dart';

abstract class Widgets {
  static scaffold(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget>? actions,
    bool mostrarAppBar = true,
    double tamanhoBarra = 50,
    required Widget child,
  }) {
    return Scaffold(
      appBar: mostrarAppBar
          ? AppBar(
              title: Text(title),
              leading: leading,
              actions: actions,
            )
          : null,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: child,
      ),
    );
  }

  static _baseButton({required Widget child, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.alternative.withOpacity(0.4),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        width: 284,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.alternative,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(child: child),
      ),
    );
  }

  static button({required String text, required void Function() onTap}) {
    return Widgets._baseButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  static buttonWithIcon({
    required String text,
    required IconData icon,
    required void Function() onTap,
  }) {
    return Widgets._baseButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
          )
        ],
      ),
      onTap: onTap,
    );
  }

  static listImage(AppFile appFile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        border: Border.all(width: 1),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            appFile.fileUrl,
            cacheKey: appFile.md5Hash,
          ),
        ),
      ),
    );
  }
}
