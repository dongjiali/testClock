//
//  RootViewController.m
//  testClock
//
//  Created by l_ch_g on 13-6-19.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import "RootViewController.h"
#import "SetClockViewController.h"
#import "FMDatabase.h"
#import "ClockModel.h"
#import "RootCell.h"
@interface RootViewController ()

@end

@implementation RootViewController
@synthesize path;
@synthesize myTableview;
@synthesize dataArray;
@synthesize arrayTag;
@synthesize arrayNotiDate;
@synthesize labelNoClock;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
//-(void)viewDidAppear:(BOOL)animated
{
    DateOK =YES;
    [super viewDidAppear:animated];
    [self readDataForClock];
   // [myTableview reloadData];
 

}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    [super viewDidDisappear:animated];
    DateOK=NO;

}
#pragma mark respondTime
//  开启定时
-(void)NotificaTionStart
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSDateFormatter *dataFormatterUpdate = [[NSDateFormatter alloc]init];
    dataFormatterUpdate.locale=[NSLocale currentLocale];
    [dataFormatterUpdate setDateFormat:@"yyyy-MM-dd"];
    NSString *strYearDate=[dataFormatterUpdate stringFromDate:[NSDate date]];
    [dataFormatterUpdate release];

    FMDatabase *db = [FMDatabase databaseWithPath:path];
    BOOL res= [db open];
    if (res == NO) {
        NSLog(@"open error");
        return;
    }
    /*查询数据库的date更改dateall*/
        FMResultSet *set = [db executeQuery:@"select *from CLOCKDATE where opensw=?",@"0"];
        while ([set next]) {
            NSString *dateNoti = [set objectForColumnName:@"dateall"];
            NSString *strCellState= [set objectForColumnName:@"cellon"];
            NSString *strID = [set objectForColumnName:@"idindex"];
            NSString *week1 = [set objectForColumnName:@"week1"];
            NSString *week2 = [set objectForColumnName:@"week2"];
            NSString *week3 = [set objectForColumnName:@"week3"];
            NSString *week4 = [set objectForColumnName:@"week4"];
            NSString *week5 = [set objectForColumnName:@"week5"];
            NSString *week6 = [set objectForColumnName:@"week6"];
            NSString *week7 = [set objectForColumnName:@"week7"];
            NSString *dateDay = [set objectForColumnName:@"date"];
            NSArray *arr = [NSArray arrayWithObjects:dateNoti,week1,week2,week3,week4,week5,week6,week7, strCellState,strID,dateDay,nil];
            [arrayNotiDate addObject:arr];
        }
    [db close];
    
    //获取现在时星期几
    NSDateComponents*comps;
    NSInteger weekday;
    NSDate*date = [NSDate date];
    NSCalendar*calendarcer = [NSCalendar currentCalendar];
    comps = [calendarcer components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:date];
    weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    if (weekday == 2) {
        NSLog(@"11111111111111111111111111111");
        //星期一
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone *gtmzong = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:gtmzong];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];            
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                [self tongzhiTime:fromDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate=[fromDate dateByAddingTimeInterval:24*60*60];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }else if (weekday == 3){
        NSLog(@"222222222222222222222222");
        //星期二
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self  tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate]; 
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];                
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];                
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }else if (weekday == 4){
        NSLog(@"33333333333333333333333333");
        //星期三
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([arrDate[1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([arrDate[2] isEqualToString:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([arrDate[3] isEqualToString:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([arrDate[4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([arrDate[5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }
    else if (weekday == 5){
        NSLog(@"44444444444444444444444444444");
        //星期四
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }else if (weekday == 6){
        NSLog(@"5555555555555555555555555");

        //星期5
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }   
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }else if (weekday == 7){
        NSLog(@"666666666666666666");

        //星期6
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }else if (weekday == 1){
        NSLog(@"7777777777777777777777777");
        //星期7
        for (int n=0; n < [arrayNotiDate count]; n++) {
            NSArray *arrDate = [arrayNotiDate objectAtIndex:n];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
//            NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//            [format setTimeZone:GTMzone];
            [format setTimeZone:[NSTimeZone defaultTimeZone]];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate = [[format dateFromString:[NSString stringWithFormat:@"%@ %@",strYearDate,[arrDate objectAtIndex:10]]] retain];
            if ([[arrDate objectAtIndex:1] isEqual:@"1"]) {
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*1];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:2] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*2];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:3] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*3];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:4] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*4];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:5] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*5];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:6] isEqual:@"1"]){
                NSDate *fireDate = [fromDate dateByAddingTimeInterval:24*60*60*6];
                [self tongzhiTime:fireDate withArray:arrDate];
            }
            if ([[arrDate objectAtIndex:7] isEqual:@"1"]){
                NSDate *fireDate=fromDate;
                [self tongzhiTime:fireDate withArray:arrDate];
            }
        }
    }
}
-(void)btnClockCancel
{
    //开启定时
    [self NotificaTionStart];

}
-(void)btnClockDone
{

    SetClockViewController *set = [[SetClockViewController alloc]initWithNibName:@"SetClockViewController" bundle:nil];
    [self presentViewController:set animated:YES completion:^(void){}];
    [set release];

}
-(void)topview
{

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    topView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
    [self.view addSubview:topView];
    [topView release];
    
    UIButton *btnCancel = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnCancel.frame = CGRectMake(0, 0, 50, 44);
    [btnCancel setImage:[UIImage imageNamed:@"btn_back_leftBack.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnClockCancel) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btnCancel];
    [btnCancel release];

    UIButton *btnClock = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnClock.frame = CGRectMake(270, 0, 50, 44);
    [btnClock setImage:[UIImage imageNamed:@"btn_tianjia.png"] forState:UIControlStateNormal];
    [btnClock addTarget:self action:@selector(btnClockDone) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btnClock];
    [btnClock release];

}
-(void)readDataForClock
{
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (res == NO) {
        NSLog(@"open error");
        return;
    }
    
    [dataArray removeAllObjects];
    
FMResultSet *set = [db executeQuery:@"select *from CLOCKDATE"];
    while ([set next]) {
        ClockModel *clock = [[ClockModel alloc]init];
        clock.idindex = [set stringForColumnIndex:0];
        clock.theDate = [set stringForColumnIndex:1];
        clock.timeDate = [set stringForColumnIndex:2];
        clock.cellON =   [set stringForColumnIndex:3];
        clock.week1 =   [set stringForColumnIndex:4];
        clock.week2 =   [set stringForColumnIndex:5];
        clock.week3 =   [set stringForColumnIndex:6];
        clock.week4 =   [set stringForColumnIndex:7];
        clock.week5 =   [set stringForColumnIndex:8];
        clock.week6 =   [set stringForColumnIndex:9];
        clock.week7 =   [set stringForColumnIndex:10];
        clock.dateHM = [set stringForColumn:@"timeHM"];
        clock.cellSWstate = [set stringForColumn:@"opensw"];
        [dataArray addObject:clock];
        [clock release];
        NSLog(@"zhixingle------------%@",clock.idindex);
    }
    
    [myTableview reloadData];
    [self.view addSubview:myTableview];
    if ([dataArray count]==0) {
        myTableview.hidden=YES;
        
    }else{
        myTableview.hidden=NO;
    }
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    arrayTag = [[NSMutableArray alloc]initWithCapacity:0];
    arrayNotiDate = [[NSMutableArray alloc]initWithCapacity:0];
    
    labelNoClock = [[UILabel alloc]initWithFrame:CGRectMake(140, Height/2, 80, 20)];
    labelNoClock.backgroundColor =[UIColor clearColor];
    labelNoClock.text=@"无闹钟";
    labelNoClock.font = [UIFont systemFontOfSize:20.0];
    labelNoClock.textColor = [UIColor whiteColor];
    [self.view addSubview:labelNoClock];
    
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"CLOCK.db"];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    BOOL res=[db open];//打开数据库 支持类型nsstring nsnumber nsdata
    if (res==NO) {
        NSLog(@"open error");
        return;
    }
    //创建表
    /*idindex  标记表   opensw标记打开闹钟      cellon小歇*/
    res=[db executeUpdate:@"create table if not exists CLOCKDATE(idindex,date,dateall,cellon,week1,week2,week3,week4,week5,week6,week7,opensw,timeHM)"];

    if (res==NO) {
        NSLog(@"create error");
        [db close];
        return;
    }else{
        NSLog(@"create ok");
    }
    
    [self topview];
    myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, Height-44) style:UITableViewStylePlain];
    myTableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    myTableview.delegate=self;
    myTableview.dataSource=self;
    myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableview.backgroundColor=[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
}

#pragma mark -Tableview
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (DateOK ==YES) {
        return [dataArray count];
        NSLog(@"section-----rowinsection");
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1");
    SetClockViewController *set = [[SetClockViewController alloc]initWithNibName:@"SetClockViewController" bundle:nil];
    [self presentViewController:set animated:YES completion:^(void){}];
    [set release];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Centifier=@"CELLID";
    RootCell *cell = (RootCell *)[tableView dequeueReusableCellWithIdentifier:Centifier];
    if (cell == nil) {
        cell = [[[RootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Centifier] autorelease];;
    };
    [cell.sw addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"indexpath------row=-----%d-------------------%d",indexPath.row,cell.sw.tag);
    if (DateOK) {
        ClockModel *model = [dataArray objectAtIndex:indexPath.row];
        cell.m=model;
    }
    return cell;
}
#pragma mark - 删除触发delegate
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell *cell=(RootCell *)[tableView cellForRowAtIndexPath:indexPath];
   cell.sw.hidden=YES;
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell *cell=(RootCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.sw.hidden=NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell *cell=(RootCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *strID=[NSString stringWithFormat:@"%d",cell.sw.tag];
    FMDatabase *db =[FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (res == NO) {
        NSLog(@"open error");
        return;
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [dataArray removeObjectAtIndex:indexPath.row];

        res = [db executeUpdate:@"delete from CLOCKDATE where idindex=?",strID];
        if (res == NO) {
            NSLog(@"delete error");
        }
        [db close];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self NotificaTionStart];
    }
    
    [myTableview reloadData];
}

-(void)switchAction :(UISwitch *)sender
{
    
    NSLog(@"sender.tag-----------------%d",sender.tag);
    
    FMDatabase *db =[FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (res == NO) {
        NSLog(@"open error");
        return;
    }

    if (sender.on==YES) {
        NSString *strid = [NSString stringWithFormat:@"%d",sender.tag];
        NSString *strValue=@"1";
        res = [db executeUpdate:@"update CLOCKDATE set opensw=? where idindex=?",strValue,strid];
        
    }
    else{
        NSString *strid = [NSString stringWithFormat:@"%d",sender.tag];
        NSString *strValue=@"0";
        res = [db executeUpdate:@"update CLOCKDATE set opensw=? where idindex=?",strValue,strid];
    }
    
    if (res == NO) {
        NSLog(@"update error");
    }
    [db close];
    
}


#pragma mark - tongzhishijian
-(void)tongzhiTime:(NSDate *)dateFine withArray:(NSArray *)arrFine
{
    NSLog(@" *设置闹钟*");
    /*设置闹钟*/
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    if (notification!=nil) {
        notification.alertBody=@"起床了,这是咋回事啊。。不好使呢。时间 不对吗？";
        notification.repeatCalendar = [NSCalendar currentCalendar];
        notification.repeatInterval = NSDayCalendarUnit;
        notification.repeatInterval=kCFCalendarUnitWeek;
//        NSTimeZone *gtmzong = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
//        [notification setTimeZone:gtmzong];
        [notification setTimeZone:[NSTimeZone defaultTimeZone]];
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *myURL=[user stringForKey:@"myurl"];
        if (myURL==nil) {
            notification.soundName =@"lx.caf";
        }else{
            notification.soundName = myURL;
        }
        
        
        
        NSString *notiPush = [NSString stringWithFormat:@"%@",[arrFine objectAtIndex:9]];
        
        if ([[arrFine objectAtIndex:8] isEqual:@"1"]) {
            
            //标记通知
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"isSleep",notiPush,@"notiState", nil];
            notification.userInfo=dict;
        }else{
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"isSleep",notiPush,@"notiState", nil];
            notification.userInfo=dict;
        }
        NSLog(@"datefine--------------%@",dateFine);
        notification.fireDate = dateFine;
        NSLog(@"nowdate--------------%@",[NSDate new]);
        NSLog(@"notification-------------------%@",notification.fireDate);
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        NSLog(@"本地通知开始");
    }
    [notification release];
}

-(void)dealloc
{

    [myTableview release];
    [dataArray release];
    [arrayTag release];
    [arrayNotiDate release];
    [labelNoClock release];
    [super dealloc];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end