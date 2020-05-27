import 'package:dio/dio.dart';
import '../config/config.dart';
import '../utils/shared_prefer.dart';
import './log_util.dart';
import '../utils/utils.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = HttpUtil();
    return instance;
  }
 
  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Config.serviceUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        "ctype": 6,

      },
      
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      // contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      // responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理
    // dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      bool connectivityResult = await Utils.isConnected();
      if (!connectivityResult) {
        LogUtil.v("请求网络异常，请稍后重试！");
        print('请求网络异常，请稍后重试！');
        return false;
      }

      SharedPreferUtil sp;

      sp = await SharedPreferUtil.getInstance();
      bool hasCtoken = sp.hasKey('token');
      if (hasCtoken){
        sp = await SharedPreferUtil.getInstance();
        String ctoken = sp.getString('token');

        options.headers.addAll({"ctoken": ctoken});
      }

      sp = await SharedPreferUtil.getInstance();
      bool hasCid = sp.hasKey('cid');
      if (hasCid) {
         sp = await SharedPreferUtil.getInstance();
        String cid = sp.getString('cid');
        options.headers.addAll({"cid": cid});
      }

      bool hasCityCode = sp.hasKey('cityItem');
      if (hasCityCode) {
        String cityVal = sp.getString('cityItem');
        String cityCode = Utils.stringToJson(cityVal)["cityCode"];
        options.headers.addAll({"cCode": cityCode});
      }
      
      // print(options.headers);
      return options;
    }, onResponse: (Response response) {
      // print("响应之前");
      return response;
    }, onError: (DioError e) {
      print("错误之前");
      return e;
    }));
  } 

  /*
   * get请求
   */ 
  get(url, {data, options, cancelToken, errorCallback}) async {
    print(url);
    bool connectivityResult = await Utils.isConnected();
    if (!connectivityResult) {
      LogUtil.v("请求网络异常，请稍后重试！");
      return;
    }

    Response response;
    try {
      response = await dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken, errorCallback}) async {
    bool connectivityResult = await Utils.isConnected();
    if (!connectivityResult) {
      LogUtil.v("请求网络异常，请稍后重试！");
      return;

    }

    // ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    //   print('----nnn--------');
    // print(connectivityResult);
    // if (connectivityResult == ConnectivityResult.none) {
    //   if (errorCallback != null) {
    //     errorCallback('请求网络异常，请稍后重试！');
    //   }
    //   LogUtil.v("请求网络异常，请稍后重试！");
    //   return;
    // }

    Response response;
    try {
      response = await dio.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
      // return dio.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      LogUtil.v("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      LogUtil.v("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      LogUtil.v("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      LogUtil.v("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      LogUtil.v("请求取消");
    } else {
      LogUtil.v("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
