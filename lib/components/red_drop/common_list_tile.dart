import 'package:ft_red_drop/package/config_packages.dart';

class CommonListTileWidget extends StatelessWidget {
  const CommonListTileWidget({super.key, this.title, this.icon,this.onTap});

  final String? title;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(icon,color: AppColor.primaryRed,),
            const Gap(10),
            Expanded(
              child: Text(
                title ?? "",
                style: const TextStyle().normal16w600.textColor(
                  AppColor.textColor,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined,color: AppColor.textColor,size: 20,)
          ],
        ),
      ),
    );
  }
}
