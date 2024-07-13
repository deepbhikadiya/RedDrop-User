import 'package:ft_red_drop/package/config_packages.dart';

class CommonBackButton extends StatelessWidget {
  final double? topPadding;
  const CommonBackButton({super.key, this.topPadding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding??30,left: 10),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: (){
          Get.back();
        },
      ),
    );
  }
}
