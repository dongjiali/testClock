//
//  SetClockViewController.h
//  testClock
//
//  Created by l_ch_g on 13-6-19.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetClockViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    /*tableview*/
    
    UITableView *myTableview;
    NSMutableArray *dataArray;
    
    UISwitch *CellSwitch;
    
    NSMutableDictionary *ClockDataDict;
    UIDatePicker * myDatePicker;
    BOOL refreshDone;       //判断刷新函数是否执行
    NSString *path;

}
@property (nonatomic ,retain)UITableView *myTableview;

@property (nonatomic ,retain)NSMutableArray *dataArray;

@property (nonatomic ,retain)NSMutableDictionary *ClockDataDict;

@property (nonatomic ,retain)UIDatePicker * myDatePicker;

@property (nonatomic,retain)NSString *path;

-(void)refreshTableDate;



@end
