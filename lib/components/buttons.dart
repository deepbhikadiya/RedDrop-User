import 'package:ft_red_drop/package/config_packages.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;

  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isAddButton;
  final Color? buttonColor;
  final Color? disableButtonColor;

  const CommonAppButton({
    super.key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    this.text,
    this.color,
    this.icon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
    this.isAddButton,
    this.buttonColor,
    this.disableButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    Color background = disableButtonColor ?? AppColor.secondaryColor;
    switch (buttonType) {
      case ButtonType.enable:
        {
          if (isAddButton == true) {
            background = buttonColor!;
          } else {
            background = AppColor.primaryRed;
          }
        }
        break;
      case ButtonType.disable:
        {
          background = disableButtonColor ?? AppColor.secondaryColor;
        }
        break;
      case ButtonType.progress:
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        onTap: (buttonType == ButtonType.enable) ? (onTap ?? () {}) : () {},
        child: Container(
          height: height ?? 48,
          width: width ?? double.infinity,
          decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius ?? 12), boxShadow: boxShadow),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonType == ButtonType.progress) const CircularProgressIndicator(),
              if (buttonType != ButtonType.progress)
                Center(
                  child: Text(
                    text!,
                    style: style ?? const TextStyle().normal16w600.textColor(AppColor.whiteColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
