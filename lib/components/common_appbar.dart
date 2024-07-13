import 'package:ft_red_drop/package/config_packages.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final TextStyle? textStyle;
  final bool deleteIcon;
  final Callback? ontap;
  final Callback? reloadOnTap;
  final Color? color;

  const CommonAppBar({
    super.key,
    this.title,
    this.ontap,
    this.leading,
    this.reloadOnTap,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.deleteIcon = false,
    this.textStyle,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? leading ??
              GestureDetector(
                onTap: ontap ??
                    () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.blackColor,
                ),
              )
          : Container(),
      backgroundColor: color??AppColor.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.blackColor, size: 24),
      centerTitle: true,
      titleTextStyle: textStyle ??
          const TextStyle(color: AppColor.primarySkyBlue).normal18w500,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
