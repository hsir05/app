import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/res/resources.dart';
import 'views/home.dart';
import 'views/mine.dart'; 
import './utils/utils.dart';
import './routers/application.dart';

class BottomPage extends StatefulWidget {
  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  PageController pageController;
  int page = 0;
  int lastTime = 0;

  final List<Widget> tabBodies = [
    Home(),
    Mine(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  void _pageChange(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView.builder(
            onPageChanged: _pageChange,
            controller: pageController,
            // itemCount: bottomTabs.length,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return tabBodies.elementAt(page);
            },
          ),
          floatingActionButton: Container( 
              width: ScreenUtil().getAdapterSize(52),
              height: ScreenUtil().getAdapterSize(52),
              padding: EdgeInsets.only(top:5.0),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
              ),
              child: FloatingActionButton(
                highlightElevation: 0,
                mini: true, 
                child: Image.asset('assets/scanCode.png',  fit: BoxFit.contain, width: ScreenUtil().getAdapterSize(50),),
                onPressed: (){
                  // String url = 'https://card.wecity.qq.com/v2/scan-code-nhsa?channel=AAEwpn9iWhdOrG3uhOfrF7Dd';
                  // Application.router.navigateTo(context, "/webview?title=" + Uri.encodeComponent('凭证') + '&webViewUrl=' +Uri.encodeComponent(url), transition: TransitionType.inFromRight);
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                ),
            ),
          
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar:  Theme(
          data: ThemeData(
            brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            
            ),
            
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: page == 0 ? Image.asset(
                            'assets/index-active.png',
                            width: 23.0,
                            height: 20.0,
                          ) :Image.asset(
                            'assets/index.png',
                            width: 23.0,
                            height: 20.0,
                          ),
                  title: Text('首页', style: TextStyle(color:page == 0 ? Colours.app_text : Colours.bottom_text)),
                ),
              
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, color: Colors.transparent,),
                title: Text('凭证', style: TextStyle(fontSize: 12.0, color:Color(0xffc3c5cd)),),
              ),

                BottomNavigationBarItem(
                    icon: page == 1 ? Image.asset(
                              'assets/my-active.png',
                              width: 23.0,
                              height: 20.0,
                            ) :Image.asset(
                              'assets/my.png',
                              width: 23.0,
                              height: 20.0,
                            ),
                    title: Text('我的', style: TextStyle(color:page == 1 ? Colours.app_text : Colours.bottom_text),),
                  ),
                ],
                
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0, color: Colours.app_text),
              unselectedLabelStyle:TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, ),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,

              fixedColor: Colours.app_text,
              onTap: (index) {
                setState(() {
                  if (index == 2) {
                    page = 1;
                    pageController.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                  } else if (index == 0) {
                    page = index;
                    pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                  } else {
                    print(index);
                  }
                });
              },
              currentIndex: page
            ))),
        onWillPop: () {
          int newTime = DateTime.now().millisecondsSinceEpoch;
          int result = newTime - lastTime;
          lastTime = newTime;
          if (result > 2000) {
            Utils.showToast('再按一次退出');
          } else {
            SystemNavigator.pop();
          }
          return null;
        });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
