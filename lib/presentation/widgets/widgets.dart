import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/presentation/theme/app_colors.dart';
import 'package:luz_do_mundo/presentation/widgets/person_selector.dart';
import 'package:injector/injector.dart' as injector;

import 'app_file_to_image_provider.dart';

abstract class Widgets {
  static scaffold(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget>? actions,
    bool mostrarAppBar = true,
    required Widget child,
  }) {
    return Scaffold(
      appBar: mostrarAppBar
          ? AppBar(
              title: Text(title),
              leading: leading,
              actions: actions,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: AppColors.alternative,
            )
          : null,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: child,
      ),
    );
  }

  static labelAndChild(String label, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          child,
        ],
      ),
    );
  }

  static labelAndValue(String label, String value) {
    return Widgets.labelAndChild(
      label,
      Text(
        value,
        style: TextStyle(
          fontSize: 18.sp,
        ),
      ),
    );
  }

  static labelAndImage(
    String label, {
    AppFile? profileImg,
    String? name,
    required String textIfNotFound,
    Widget? extraData,
  }) {
    if (name == null) {
      return Widgets.labelAndValue(label, textIfNotFound);
    }
    return Widgets.labelAndChildWithText(
      label,
      child: Widgets.listImage(profileImg ?? AppFile.empty()),
      extraData: extraData,
      name: name
    );
  }

  static labelAndChildWithText(
    String label, {
    required Widget child,
    required String name,
    Widget? extraData,
  }) {
    return Widgets.labelAndChild(
      label,
      Row(
        children: [
          child,
          SizedBox(
            width: 14.w,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.sp,
            ),
          ),
          if(extraData != null)
            extraData
        ],
      ),
    );
  }

  static _baseButton({required Widget child, required void Function() onTap, Color? backgroundColor}) {
    final selectedBackgroundColor = backgroundColor ?? AppColors.alternative;
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.alternative.withOpacity(0.4),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        width: 284.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: selectedBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Center(child: child),
      ),
    );
  }

  static button({required String text, required void Function() onTap, bool isLoading = false}) {
    return Widgets._baseButton(
      child: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :
      Text(
        text,
        style: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
        ),
      ),
      onTap: isLoading ? () => null : onTap,
    );
  }

  static buttonWithIcon({
    required String text,
    required IconData icon,
    required void Function() onTap,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return Widgets._baseButton(
      backgroundColor: backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: textStyle,
          )
        ],
      ),
      onTap: onTap,
    );
  }

  static listImage(AppFile appFile) {
    return render48SizeImage(
      appFileToImageProvider(appFile)
    );
  }

  static render48SizeImage(ImageProvider<Object> image) {
    return Container(
      height: 48.r,
      width: 48.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.0.r)),
        border: Border.all(width: 1.w),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }

  static void showCrudDialog<T extends BaseCrudCubit>({
    required BuildContext context,
    required void Function(BasePerson) onTap,
    required String title,
  }) {
    showDialog(
      context: context,
      builder: (localContext) {
        return BlocProvider(
          create: (context) =>
              injector.Injector.appInstance.get<T>()
                ..load(),
          child: Builder(
            builder: (localContext) {
              final listCubit = localContext.watch<T>();
              final state = listCubit.state;
              List<BasePerson>? persons;
              if (state is LoadedBaseCrudStates) {
                persons =
                    (state as LoadedBaseCrudStates<List<BasePerson>>).data;
              }
              return PersonSelector(
                onTap: onTap,
                persons: persons,
                title: title,
              );
            },
          ),
        );
      },
    );
  }

  static Widget labelAndImageWithEdits(
    String label, {
    BasePerson? person,
    required String textIfNotFound,
    Widget? extraData,
    required Function() onAddClicked,
    required Function() onEditClicked,
    required Function() onRemoveClicked,
  }) {
    if (person == null) {
      return GestureDetector(
        onTap: () => onAddClicked(),
        child: Widgets.labelAndChildWithText(
          label,
          child:
              Widgets.render48SizeImage(AssetImage("assets/images/empty.png")),
          name: textIfNotFound,
        ),
      );
    }
    return Widgets.labelAndImage(
      label,
      textIfNotFound: textIfNotFound,
      name: person.firstName,
      profileImg: person.picture,
      extraData: Row(
        children: [
          IconButton(
            onPressed: () => onEditClicked(),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: onRemoveClicked,
            icon: Icon(Icons.close),
          ),
        ],
      ),
      // extraData:
    );
  }


}
