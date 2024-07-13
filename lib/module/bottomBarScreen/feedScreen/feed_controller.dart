import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/models/post_model.dart';

import '../../../package/config_packages.dart';
class FeedController extends GetxController{

  RxList<PostModel> postList = <PostModel>[].obs;

  getAllPost() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var document in querySnapshot.docs) {
          if (document.data() is Map) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            Timestamp timestamp = data['createdAt'];

            PostModel postModel = PostModel(
              title: data['title'].toString(),
              location: data['location'].toString(),
              imageUrls:  List<String>.from(data['imageUrls']),
              createdAt: timestamp.toDate(),
            );

            postList.add(postModel);
          } else {
            print("Data is not in the expected format.");
          }
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    print(postList);
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAllPost();

  }

}