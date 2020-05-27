# dio 使用

## 1.初始化 

```dio
//初始化 Http，
  HttpManager().init(
    baseUrl: Api.getBaseUrl(),
    interceptors: [
      HeaderInterceptor(),
      LogInterceptor(),
    ],
  );

```

## 2. 创建网络请求

```dio
///同步回调模式
///get 网络请求
void _get(){
   HttpManager().get(
      url: "/app/info",
      params: {"iouCode": iouCode},
      successCallback: (data) {
        
      },
      errorCallback: (HttpError error) {
       
      },
      tag: "tag",
    );
}
///post 网络请求
void _post(){
     HttpManager().post(
      url: "/app/info",
      data: {"iouCode": iouCode},
      successCallback: (data) {
        
      },
      errorCallback: (HttpError error) {
        
      },
      tag: "tag",
    );
}

///下载文件
void _download(){
     HttpManager().download(
      url: "/app/download",
      savePath: "/savePath",
      onReceiveProgress: (int count, int total) {
      },
      successCallback: (data) {
        
      },
      errorCallback: (HttpError error) {
        
      },
      tag: tag,
    );
}

///上传文件
void _upload() async{
FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename: "$photoTime"),
      });
    HttpManager().upload(
        url: "/app/upload",
        data: data,
        tag: "tag",
        successCallback: (data) {
          
        },
        errorCallback: (HttpError error) {
          
        },
      );
}


///异步模式
///get 请求
void _getAysnc() async{
     String timestamp =
        await HttpManager().getAsync(url: "/app/info", tag: "syncTime");
}

///post 请求
void _postAysnc() async{
   await HttpManager().postAsync(
        url: "app/info",
        tag: "tag",
        data: {
          'bannerTypes': ["wealthBanner"],
        },
        jsonParse: (json) => Pager(json, (data) => ImageAd(data)))
}

///下载文件
void _downloadAsync() async{
    await HttpManager().downloadAsync(
      url: "/app/download",
      savePath: "/savePath",
      onReceiveProgress: (int count, int total) {
      },
      tag: "tag",
    );
}

///上传文件
void _uploadAsync() async{
FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename: "$photoTime"),
      });
  await  HttpManager().uploadAsync(
        url: "/app/upload",
        data: data,
        tag: "tag",
       
      );
}

```
