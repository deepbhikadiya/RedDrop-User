import 'package:ft_red_drop/package/config_packages.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget({super.key, this.title, this.subTitle,this.gap});

  final String? title;
  final String? subTitle;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle().normal24w600.textColor(
                AppColor.textColor,
              ),
        ),
        Gap(gap??0),
        Text(
          subTitle ?? "",
          style: const TextStyle().normal16w500.textColor(
                AppColor.secondaryColor,
              ),
        ),
      ],
    );
  }
}
