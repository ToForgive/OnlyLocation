//
//  ViewController.m
//  OnlyLocation
//
//  Created by Mr.S on 2016/12/22.
//  Copyright © 2016年 ST.MEDIA. All rights reserved.
//

#import "ViewController.h"
#import "OnlyLocationManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationStateChange:) name:LocationStateNoti object:nil];
    
    [OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
        
    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
        [self locationSuccess:locationVO];
    }];
}

- (IBAction)updateLocation:(UIButton *)sender {
    sender.enabled = NO;
    [OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
        
    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
        sender.enabled = YES;
        [self locationSuccess:locationVO];
    }];
}

-(void)locationSuccess:(OnlyLocationVO *)locationVO{
    self.resultLabel.text = locationVO.formatted_address;
}

-(void)locationStateChange:(NSNotification* )noti{
    OnlyLocationManager* manager = [OnlyLocationManager getLocationManager];
    NSLog(@"%ld",manager.state);
    
    NSString* stateStr = @"初始化";
    switch (manager.state) {
        case 0:
            stateStr = @"初始化失败";
            break;
        case 1:
            stateStr = @"定位中";
            break;
        case 2:
            stateStr = @"已获取初始位置并持续定位中";
            break;
        case 3:
            stateStr = @"已定位，正在逆地理编码";
            break;
        case 4:
            stateStr = @"已定位，逆地理编码完成";
            break;
        case 5:
            stateStr = @"已定位，逆地理编码失败";
            break;
    }
    
    NSLog(@"%@",stateStr);
    self.title = stateStr;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
