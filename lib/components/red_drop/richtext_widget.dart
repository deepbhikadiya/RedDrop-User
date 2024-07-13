import 'package:ft_red_drop/package/config_packages.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key, this.onTap, this.text1, this.text2});

  final Function()? onTap;
  final String? text1, text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1 ?? "",
          style: const TextStyle().normal14w500.textColor(AppColor.textColor),
        ),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Text(
            text2 ?? "",
            style:
                const TextStyle().normal14w500.textColor(AppColor.primaryRed),
          ),
        ),
      ],
    );
  }
}
