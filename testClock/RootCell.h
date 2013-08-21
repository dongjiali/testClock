//
//  RootCell.h
//  testClock
//
//  Created by l_ch_g on 13-6-23.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockModel.h"
@interface RootCell : UITableViewCell
{

    ClockModel *_m;
    UILabel *labelTime;
    UILabel *labelWeek;
    UISwitch *sw;
    UIView *bgView;

}

@property (nonatomic ,retain)ClockModel *m;

@property (nonatomic ,retain)UISwitch *sw;

@property (nonatomic ,retain)UILabel *labelTime;

@property (nonatomic ,retain)UILabel *labelWeek;

@end
