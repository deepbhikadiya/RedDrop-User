
// ignore: must_be_immutable
import '../../../package/config_packages.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PdfViewer extends StatefulWidget {
  bool? isShare;
  String? title;
  String? path;
  PdfViewer({Key? key, this.isShare, this.title,this.path}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  int? pages = 1;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar:
        AppBar(
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          title:  Text(
            widget.title??"",
            style: const TextStyle(color: AppColor.textColor2).normal18w500,
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          elevation: 0,

        ),
        body:
        SfPdfViewer.asset(widget.path??"")

      ),
    );
  }
}
