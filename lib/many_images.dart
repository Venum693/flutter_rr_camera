
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:images_picker/images_picker.dart';


class PickMultipleImagesScreen extends StatefulWidget {
  const PickMultipleImagesScreen({super.key});

  @override
  _PickMultipleImagesScreenState createState() =>
      _PickMultipleImagesScreenState();
}

class _PickMultipleImagesScreenState extends State<PickMultipleImagesScreen> {
  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);
  List compressedPhotosList = ["place_holder"];
  int maxImagesCount = 5;

  pickPhotos() async {
    List<Media>? photosList = [];
    photosList = await ImagesPicker.pick(
      count: (compressedPhotosList != null &&
          (compressedPhotosList.isNotEmpty) &&
          (compressedPhotosList.length > 1))
          ? (maxImagesCount + 1 - compressedPhotosList.length)
          : maxImagesCount,
      pickType: PickType.all,
      language: Language.System,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio(600, 400),
      ),
    );

    if (photosList != null && photosList.isNotEmpty && photosList.length > 0) {
      for (int i = 0; i < photosList.length; i++) {
        File photoCompressedFile =
        (await compressImage(File(photosList[i].path))) as File;
        print("Images List: $photosList");
        print("Path of UnCompressed File: ${photosList[i].path}");
        compressedPhotosList.insert(
          0,
          photoCompressedFile.path.toString(),
        );
        print("Path of Compressed File: ${photoCompressedFile.path}");
        print("Compressed Images List: $compressedPhotosList");
      }
      attachMultipleImages.value = !attachMultipleImages.value;
    }
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(new RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<bool>(
          valueListenable: attachMultipleImages,
          builder: (context, snapshot, child) {
            return Scaffold(
              body: (compressedPhotosList != null &&
                  compressedPhotosList.isNotEmpty &&
                  compressedPhotosList.length > 1)
                  ? GridView.builder(
                itemCount: (compressedPhotosList != null &&
                    compressedPhotosList.isNotEmpty &&
                    compressedPhotosList.length > 1 &&
                    (compressedPhotosList.length - 1 == maxImagesCount))
                    ? compressedPhotosList.length - 1
                    : compressedPhotosList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return ((compressedPhotosList[index] == "place_holder") &&
                      compressedPhotosList.length - 1 != maxImagesCount)
                      ? InkWell(
                    onTap: () async {
                      if (compressedPhotosList.length - 1 !=
                          maxImagesCount) {
                        pickPhotos();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(
                        5.0,
                      ),
                      //width: ScreenUtil().screenWidth,
                      //height: ScreenUtil().setHeight(105.0),
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          //size: ScreenUtil().setSp(24.0),
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                      : Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.file(
                          File(compressedPhotosList[index]),
                          fit: BoxFit.fitHeight,
                         /* width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setHeight(105.0),*/

                          width: 50,
                          height: 50,
                          filterQuality: FilterQuality.low,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                             /* width: ScreenUtil().screenWidth,
                              height: ScreenUtil().setHeight(105.0),*/

                              width: 50,
                              height: 50,
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 8,
                        child: InkWell(
                          onTap: () async {
                            compressedPhotosList.removeAt(index);
                            attachMultipleImages.value =
                            !attachMultipleImages.value;
                          },
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.black45,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
                  : Center(
                child: InkWell(
                  onTap: () {
                    pickPhotos();
                  },
                  child: Text("Attach Images"),
                ),
              ),
            );
          }
      ),
    );
  }
}