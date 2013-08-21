//
//  RpeatViewController.h
//  testClock
//
//  Created by l_ch_g on 13-6-21.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SetClockViewController;
@interface RpeatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *myTbaleview;
    NSMutableArray *dataArray;
    SetClockViewController *setClock;
    NSMutableArray *weekArr;
    BOOL CellON ;

}
@property (nonatomic ,retain)UITableView *myTbaleview;

@property (nonatomic ,retain)NSMutableArray *dataArray;

@property (nonatomic ,retain)SetClockViewController *setClock;

@property (nonatomic ,retain)    NSMutableArray *weekArr;

@end
