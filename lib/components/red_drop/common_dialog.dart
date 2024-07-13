import 'package:ft_red_drop/package/config_packages.dart';

commonDialog({required String image,String? text,void Function()? onTap,FutureOr<dynamic> Function(dynamic)? then}) {
  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Material(child: Container(
                        height: 185,
                        color: AppColor.whiteColor,
                        child: Image.asset(image))),
                    const Gap(20),
                    Material(
                      child: Text(text??"",
                        style: const TextStyle()
                            .normal16w500
                            .textColor(AppColor.textColor2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: GestureDetector(
                        onTap: onTap??(){
                          Get.back();
                          Get.back();
                        },
                        child: const CircleAvatar(
                          radius: 23,
                          backgroundColor: AppColor.primaryRed,
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).then(then??(val){});
}
