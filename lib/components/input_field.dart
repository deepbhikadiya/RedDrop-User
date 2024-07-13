import 'package:ft_red_drop/package/config_packages.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool firstCapital;
  final bool disable;
  final bool readOnly;
  final String hint;
  final String? prefixImage;

  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final double? width;
  final Color? textFieldColor;
  final TextStyle? hintStyle;
  final Color? borderColor;

  const InputField(
      {super.key,
      required this.controller,
      this.focusNode,
      this.obscureText = false,
      this.readOnly = false,
      this.disable = false,
      this.firstCapital = false,
      this.hint = "",
      this.onChange,
      this.inputFormatter,
      this.prefixImage,
      this.onSubmitted,
      this.onTap,
      this.textInputAction,
      this.keyboardType,
      this.validator,
      this.maxLine,
      this.width,
      this.suffixIcon,
      this.textFieldColor,
      this.hintStyle,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        onTap: onTap ?? () {},
        textCapitalization:
            firstCapital ? TextCapitalization.words : TextCapitalization.none,
        cursorColor: AppColor.textColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: false,
        obscureText: obscureText,
        maxLines: maxLine,
        readOnly: readOnly,
        inputFormatters: inputFormatter ?? [],
        style: disable
            ? const TextStyle(color: AppColor.secondaryColor).normal14w500
            : const TextStyle(color: AppColor.textColor).normal14w500,
        decoration: InputDecoration(
          isCollapsed: true,
          enabled: !disable,
          hintStyle: hintStyle ??
              const TextStyle(color: AppColor.secondaryColor).normal14w500,
          fillColor: textFieldColor ?? AppColor.whiteColor,
          contentPadding:
              const EdgeInsets.only(top: 13, bottom: 13.0, right: 16,left: 16),
          hintText: hint,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: borderColor ??
                  AppColor.secondaryTextColor,
            ),
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: borderColor ??
                  AppColor.secondaryTextColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: borderColor ?? AppColor.textColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: borderColor ?? AppColor.textColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: borderColor ?? AppColor.textColor,
            ),
          ),
          prefixIcon: prefixImage!= null?Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8),
            child: SizedBox(
              height: 24,
              width: 24,
              child: Image.asset(
                prefixImage ?? "",
                fit: BoxFit.fitHeight,
                color: AppColor.secondaryColor,
              ),
            ),
          ):null,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
              left: 8,
            ),
            child: suffixIcon,
          ),
          filled: true,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 48,
            maxWidth: 48,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 48,
            maxWidth: 48,
          ),
        ),
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: firstCapital
            ? TextInputType.text
            : keyboardType ?? TextInputType.name,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },
        onFieldSubmitted: onSubmitted,
        validator: (val) {
          if (validator != null) {
            return validator!(val);
          } else {
            return null;
          }
        },
      ),
    );
  }
}
