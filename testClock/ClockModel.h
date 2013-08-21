//
//  ClockModel.h
//  testClock
//
//  Created by l_ch_g on 13-6-23.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockModel : NSObject
{
    NSString *_idindex;
    NSString *_theDate;
    NSString *_timeDate;
    NSString *_cellON;
    NSString *_week1;
    NSString *_week2;
    NSString *_week3;
    NSString *_week4;
    NSString *_week5;
    NSString *_week6;
    NSString *_week7;
    NSString *_dateHM;          //记录带秒的时间
    NSString *_cellSWstate;
    

}
@property (nonatomic ,retain)NSString *theDate;
@property (nonatomic ,retain)NSString *timeDate;
@property (nonatomic ,retain)NSString *cellON;
@property (nonatomic ,retain)NSString *idindex;
@property (nonatomic ,retain)NSString *dateHM;
@property (nonatomic ,retain)NSString *week1;
@property (nonatomic ,retain)NSString *week2;
@property (nonatomic ,retain)NSString *week3;
@property (nonatomic ,retain)NSString *week4;
@property (nonatomic ,retain)NSString *week5;
@property (nonatomic ,retain)NSString *week6;
@property (nonatomic ,retain)NSString *week7;
@property (nonatomic ,retain)NSString *cellSWstate;

@end










