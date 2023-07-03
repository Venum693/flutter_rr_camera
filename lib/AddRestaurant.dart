import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rr_camera/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final restaurantLoading = StateProvider.autoDispose((ref) => false);


class AddRestuarant extends ConsumerStatefulWidget {
  const AddRestuarant({super.key});

  @override
  ConsumerState<AddRestuarant> createState() => _AddRestuarantState();
}

class _AddRestuarantState extends ConsumerState<AddRestuarant> {

  ImagePicker picker =ImagePicker();
  List<File> imageList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Restaurant',style: GoogleFonts.poppins(
            color: Color(0xffF2F2F2),fontSize: 20),),
        backgroundColor: Color(0xff0E0E10),
        leading: Icon(Icons.arrow_back_ios),
        actions: [
          Icon(Icons.check)],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child:
          imageList.isEmpty ? GestureDetector(
            onTap: () {
              getCameraImage();
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.301,
              width: MediaQuery.of(context).size.width/1.049,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffD9D9D9).withOpacity(0.6)
                //AppColors.containerFill,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined,color: AppColors.text,size: 50,),
                  Text('Upload Photo',style: GoogleFonts.poppins(fontSize: 24,color: AppColors.text),)
                ],
              ),
            ),
          )

          :

              Stack(
                children: [
                  CarouselSlider.builder(
                      itemCount: imageList.length,
                      itemBuilder: (_,i,__){
                        return GestureDetector(


                          child: Container(
                            //height: 200,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                                image: DecorationImage(
                                    image: FileImage(imageList[i]),
                                )
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [Color(0xff262626).withOpacity(0.8),Color(0xff262626).withOpacity(0.8),],begin: Alignment.centerRight,end: Alignment.centerLeft),

                                ),
                                child: Text('${imageList.indexOf(imageList[i])+1}/${imageList.length}'),
                              ),
                            ),
                          ),


                          onTap: () {
                            //onTap, A new Page is loaded where the user can view an enlarged image
                            //and also delete the selected image
                            Navigator.push(
                                context, MaterialPageRoute(
                              fullscreenDialog: true,
                                builder: (BuildContext context){
                                return Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.black,
                                    title: Text('Delete photo'),
                                    centerTitle: true,
                                    actions: [
                                      IconButton(
                                          onPressed: (){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: Color(0xff3C3C3C),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10)),
                                                    contentPadding: EdgeInsets.only(top: 0.0),
                                                    content: Container(
                                                      width: MediaQuery.of(context).size.width/1.2,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            height: MediaQuery.of(context).size.height*0.081,
                                                            width: MediaQuery.of(context).size.width/1.2,
                                                            decoration: const BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                                                )
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Please Confirm',
                                                                textScaleFactor: 1,
                                                                style: GoogleFonts.poppins(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w600,color: Color(0xFFF2F2F2)),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 12,),
                                                          Center(
                                                            child: Text(
                                                              'This Photo will be deleted permanently',

                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Color(0xffF2F2F2).withOpacity(0.7)),
                                                              textAlign: TextAlign.center,
                                                              textScaleFactor: 1,),
                                                          ),
                                                          SizedBox(height: 24,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 20),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                TextButton(
                                                                    onPressed: ()  {

                                                                      //imageList.remove(imageList[i]);

                                                                      imageList.removeAt(i);
                                                                      Navigator.pop(context,MaterialPageRoute(builder: (context)=>AddRestuarant()));
                                                                      print('image RREMOVED image image length = ${imageList.length} ----------' );

                                                                      //Navigator.pop(ctx);
                                                                      //Navigator.pop(context);

                                                                      setState(() {
                                                                        //imageList.removeAt(i);
                                                                      });

                                                                      //await imageList[i].


                                                                    },
                                                                    child: Text('Yes',  textScaleFactor: 1, style: GoogleFonts.poppins(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w600,color: Color(0xffF2F2F2)),
                                                                    )),
                                                                TextButton(
                                                                    onPressed: (){

                                                                      print('imageList imageList imageList imageList ${imageList}');

                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Text('No',textScaleFactor: 1, style: GoogleFonts.poppins(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w600,color: Color(0xffF2F2F2)),
                                                                    ))
                                                              ],
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.delete_rounded))
                                    ],
                                  ),
                                  body: GestureDetector(
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                        child: Container(
                                           width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,


                                          child: Image.file(imageList[i]),
                                        ),
                                      )
                                      ],
                                    ),
                                  ),
                                );
                                }
                            )
                            );
                          },
                        );
                      },
                      options: CarouselOptions(
                       /* enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16/9,
                        viewportFraction: 0.9*/

                          enlargeCenterPage: true,
                          autoPlay: false,
                          //aspectRatio: 4,
                          //autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration: Duration(
                              milliseconds: 800),
                          viewportFraction: 0.51,
                          //autoPlay: false,
                          /*height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5338*/
                        height: 230
                      )
                  ),
                  Align(
                   alignment: Alignment.centerRight,
                   child: IconButton(
                     onPressed: () {
                       getCameraImage();
                     },
                     icon: Icon(Icons.add_circle, color: Colors.white,size: 40),
                     
                   ),
                  )
                ],
              )
        ),
      )
    );
  }

  Future<void> getCameraImage() async {
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      maxWidth: 2272,
      maxHeight: 1704,
      imageQuality: 90,
      requestFullMetadata: true
    );

    setState(() {
      imageList.add(File(pickedFile!.path));
    });
  }
}
