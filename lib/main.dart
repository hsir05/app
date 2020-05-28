import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:app/res/resources.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './provider/userInfo.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './views/splash.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,//状态栏
        systemNavigationBarColor:Color(0xfff0f0f0),//虚拟按键背景色
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,//虚拟按键图标色
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserInfoState()),
      ],
      child: MaterialApp(
          title:'甘肃医保服务平台',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primaryColor: Colours.app_main,
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            const FallbackCupertinoLocalisationsDelegate()
          ],
          supportedLocales: [
            const Locale('zh', 'CN'),
          ],
          home: SplashPage(),
      )
    );
  }
}


class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();
 
  @override
  bool isSupported(Locale locale) => true;
 
  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);
 
  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}


