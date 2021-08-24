import 'package:flutter/material.dart';
import 'package:last_try/network/local/cache_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shop_app/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var pageController=PageController();
  bool isLast=false;
  int activeStep=0;

  List pages=[
    {
      'image':'assets/images/1.png',
      'title':'First Title',
      'body':'First Body',
    },
    {
      'image':'assets/images/2.png',
      'title':'Second Title',
      'body':'Second Body',
    },
    {
      'image':'assets/images/3.png',
      'title':'Third Title',
      'body':'Third Body',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                navigateAndFinish(context: context, widget: LoginScreen());
                CacheHelper.saveData(key: 'onBoarding', value: true);
              },
              child: Text(
                  'SKIP',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: BouncingScrollPhysics(),
                itemBuilder:(context,index)=>buildOnBoardingItem(
                  image: pages[index]['image'],
                  title: pages[index]['title'],
                  body: pages[index]['body'],
                ),
              itemCount: pages.length,
              onPageChanged: (index){
                activeStep=index;
                  setState(() {
                    if(index==pages.length-1)
                        isLast=true;
                    else
                      isLast=false;
                  });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count:  3,
                  axisDirection: Axis.horizontal,
                  effect:  ExpandingDotsEffect(
                      spacing:  5.0,
                      //paintStyle:  PaintingStyle.stroke,
                      //strokeWidth:  1.5,
                      dotWidth: 20,
                      dotColor:  Colors.grey.shade300,
                      activeDotColor:  Colors.black87
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    if(!isLast)
                      {
                        pageController.nextPage(
                          duration: Duration(microseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    else{
                      navigateAndFinish(context: context, widget: LoginScreen());
                      CacheHelper.saveData(key: 'onBoarding', value: true);
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnBoardingItem({
  @required String? image,
    @required String? title,
    @required String? body,
}) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image!,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(body!),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
