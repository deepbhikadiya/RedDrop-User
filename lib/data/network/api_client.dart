
import 'package:ft_red_drop/components/buttons.dart';
import 'package:ft_red_drop/components/common_fun.dart';

import 'package:ft_red_drop/utils/extension/extensions.dart';

import '../../package/config_packages.dart';
void showErrorSheet(String errorText,
    {Function()? onTap, String? buttonTitle}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    builder: (context) => Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsetsDirectional.only(
          start: 24,
          end: 24,
          top: 18,
          bottom: context.bottomPaddingIfNeeded(18)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text("Error")),
          const Gap(16),
          for (var data in errorText.split(',')) ...{
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 4),
                    child: CircleAvatar(
                        backgroundColor: context.textTheme.titleLarge?.color,
                        radius: 5),
                  ),
                  const Gap(8),
                  Expanded(child: Text(data.trim().capitalizeFirst ?? "")),
                ],
              ),
            ),
          },
          const Gap(16),
          CommonAppButton(
              text: "Ok",
              buttonType: ButtonType.enable,
              onTap: () {
                hideKeyboard();
                Navigator.pop(context);
              })
        ],
      ),
    ),
  );
}
