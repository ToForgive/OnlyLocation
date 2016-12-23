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
    
    [OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
        
    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
        
    }];
}

@end
