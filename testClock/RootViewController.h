//
//  RootViewController.h
//  testClock
//
//  Created by l_ch_g on 13-6-19.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSString *path;     //路径
    UITableView *myTableview;
    NSMutableArray *dataArray;
    BOOL DateOK;
    NSMutableArray *arrayTag;   //标识通知时间
    NSMutableArray *arrayNotiDate;  //通知时间
    UILabel *labelNoClock;          //显示无闹钟
    
}

@property (nonatomic,retain)NSString *path;

@property (nonatomic ,retain)UITableView *myTableview;

@property (nonatomic ,retain)NSMutableArray *dataArray;

@property (nonatomic ,retain)NSMutableArray *arrayTag;

@property (nonatomic ,retain)NSMutableArray *arrayNotiDate;

@property (nonatomic ,retain)UILabel *labelNoClock;



@end











