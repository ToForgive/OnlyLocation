//
//  OnlyLocationManager.m
//  OnlyLocation
//
//  Created by Mr.S on 2016/12/22.
//  Copyright © 2016年 ST.MEDIA. All rights reserved.
//

#import "OnlyLocationManager.h"

@interface OnlyLocationManager ()

@end

@implementation OnlyLocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)shareManager{
    static OnlyLocationManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OnlyLocationManager alloc]init];
    });
    return manager;
}

@end
