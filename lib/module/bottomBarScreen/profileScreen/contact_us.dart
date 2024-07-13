import 'package:ft_red_drop/components/red_drop/common_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../package/config_packages.dart';
import '../../../package/screen_packages.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: true,
        title: Text(S
            .of(context)
            .contact_us, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CommonListTileWidget(
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: "+916355158782",
                );
                await launchUrl(launchUri);
              },
              title: "+91 63551 58782",
              icon: Icons.call,
            ),
            const Gap(10),
            CommonListTileWidget(
              onTap: () async  {
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'admin@gmail.com',
                );

                var url = params.toString();
                if (await canLaunch(url)) {
                await launch(url);
                } else {
                throw 'Could not launch $url';
                }
              },
              title: "admin@gmail.com",
              icon: Icons.email,
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
