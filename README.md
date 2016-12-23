# OnlyLocation

> **注** NetAndUDManager是我的通用工具，如果使用过我做的其他工具请先检查是否已经包含NetAndUDManager文件。
> 
> 很多APP有的时候只需要定位信息，但是并不需要地图显示或者搜索功能，所以没有必要集成各种第三方地图SDK，OnlyLocation是基于iOS 原生定位系统封装的定位工具。

##准备(如果只需要经纬度信息则不需要看这部分)
由于系统自带的反地理编码没有返回cityCode所以工具中使用的是百度地图的webAPI，所以如果需要反地理编码的话需要先前往[百度地图开放平台](http://lbsyun.baidu.com/apiconsole/key)创建应用。

###创建服务端应用
**创建服务端，不要创建iOS端**
![创建服务端应用](http://p1.bqimg.com/567571/79ca93abde88ce08.png)
⬇️名字可以随便写
![创建服务端应用](http://p1.bqimg.com/567571/dedc12e9f135a489.png)

###设置ak
创建好以后将获得的ak设置到OnlyLocationManager.h中。

```objc
//设置反地理编码ak
#define GEOCODINGAK @"a31UK8dZVT2OoGuOi3DqU1GL"
```

>  **注** 得到的ak可以给多个app使用，如果app使用量较大，建议每个app对应一个专用的ak

##使用

初始化、发起定位、更新位置都是一个方法

```objc
[OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
        //初始化结果，可以在此处对manager进行设置
    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
    	//定位结果回调
        [self locationSuccess:locationVO];
    }];
```

工具保存了每一次的定位结果，每次定位成功会将上一次的定位结果覆盖所以可以获取上一次定位信息

```objc
OnlyLocationVO * location = [OnlyLocationManager  getOldLocation];
```
工具中可以进行持续定位，但是持续定位时为保证性能和流量消耗没有进行反地理编码，所以如果想根据当前位置获得具体位置信息进行反地理编码可以调用如下方法

```objc
[OnlyLocationManager  getLocation: ^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
        //反地理编码回调
    }];
```

另外工具中对定位过程进行了监听并使用通知中心进行了回调，建议开发者监听LocationStateNoti通知，每次定位过程状态改变都会触发该通知，并且可以根据OnlyLocationManager的state属性判断当前所处状态。

```objc
typedef NS_ENUM(NSInteger, LocationState) {
    LocationInitFiled   = 0, //初始化失败
    InLocalization      = 1, //定位中
    Continually         = 2, //已获取初始位置并持续定位中
    LocatedNOVO         = 3, //已定位，正在逆地理编码
    Located             = 4, //已定位，逆地理编码完成
    LocatedVOFiled      = 5, //已定位，逆地理编码失败
};
```

##后续改进
- 使用不同系统版本进行真机调试，检测bug，优化代码。
- 。。。
