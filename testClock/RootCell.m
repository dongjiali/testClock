//
//  RootCell.m
//  testClock
//
//  Created by l_ch_g on 13-6-23.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import "RootCell.h"

@implementation RootCell
@synthesize sw;
@synthesize labelTime;
@synthesize labelWeek;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *v=[self getView];
        [self.contentView addSubview:v];

    }
    return self;
}

-(UIView *)getView
{
    
    bgView=[[UIView alloc]initWithFrame:CGRectMake(8, 0, 320, 60)];
    labelTime=[[UILabel alloc]initWithFrame:CGRectMake(8, 5, 120, 30)];
    labelTime.textAlignment = NSTextAlignmentLeft;
    labelTime.font=[UIFont systemFontOfSize:24.0];
    labelTime.textColor=[UIColor whiteColor];
    labelTime.backgroundColor=[UIColor clearColor];
    [bgView addSubview:labelTime];
    
    labelWeek=[[UILabel alloc]initWithFrame:CGRectMake(8, 35, 230, 20)];
    labelWeek.lineBreakMode=NSLineBreakByTruncatingHead;
    labelWeek.textAlignment = NSTextAlignmentLeft;
    labelWeek.font=[UIFont systemFontOfSize:14.0];
    labelWeek.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    labelWeek.backgroundColor=[UIColor clearColor];
    [bgView addSubview:labelWeek];
    
    sw = [[UISwitch alloc]initWithFrame:CGRectMake(230, 15, 50, 20)];
   // sw.on=NO;
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:@"0" forKey:@"isSleep"];
    [userInfo synchronize];
    [bgView addSubview:sw];
    
    UILabel *labelview=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 310, 1)];
    labelview.backgroundColor=[UIColor colorWithRed:59.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1];
    [bgView addSubview:labelview];
    
    return bgView;
    
    
}

-(ClockModel *)m
{

    return _m;
}
-(void)setM:(ClockModel *)m
{

    if (m!=_m) {
        [_m release];
        _m = [m retain];
        labelTime.text = [NSString stringWithFormat:@"%@",_m.dateHM];
        sw.tag = [_m.idindex intValue];
        NSLog(@"cellSWstate------mm--------%@------------%d",_m.cellSWstate,sw.tag);
        if ([_m.cellSWstate isEqual:@"1"]) {
            sw.on=YES;
        }else{
            sw.on=NO;
        }
        //
        NSString *pString = @"";
        bool isWork = false;
        
        if ([_m.week1 isEqual:@"1"]) {
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周一"];
            isWork = true;
        }
        if ([_m.week2 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周二"];
            isWork = true;
        }
        if ([_m.week3 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周三"];
            isWork = true;
        }
        if ([_m.week4 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周四"];
            isWork = true;
        }
        if ([_m.week5 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周五"];
            isWork = true;
        }
        if ([_m.week6 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周六"];
            isWork = true;
        }
        if ([_m.week7 isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周日"];
            isWork = true;
        }
        

        labelWeek.text = pString;
        
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [labelTime release];
    [labelWeek release];
    [sw release];
    [bgView release];

    [super dealloc];


}
@end
