//
//  RpeatViewController.m
//  testClock
//
//  Created by l_ch_g on 13-6-21.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import "RpeatViewController.h"
#import "SetClockViewController.h"

@interface RpeatViewController ()

@end

@implementation RpeatViewController
@synthesize myTbaleview;
@synthesize dataArray;
@synthesize setClock;
@synthesize weekArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)btnClockCancel
{
 //   [setClock refreshTableDate];
    NSLog(@"555---%@",setClock.myTableview);
    [self dismissModalViewControllerAnimated:YES];

}

-(void)viewDidDisappear:(BOOL)animated
{

}

-(void)topview
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    topView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
    [self.view addSubview:topView];
    [topView release];
    
    UIButton *btnCancel = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnCancel.frame = CGRectMake(10, 0, 70, 44);
    [btnCancel addTarget:self action:@selector(btnClockCancel) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setImage:[UIImage imageNamed:@"btn_fanhui.png"] forState:UIControlStateNormal];
    [topView addSubview:btnCancel];
    [btnCancel release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
    [self topview];
    dataArray = [[NSMutableArray alloc]initWithObjects:@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六",@"每周日",nil];
    weekArr = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];

    myTbaleview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, Height-44) style:UITableViewStyleGrouped];
    myTbaleview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    myTbaleview.delegate=self;
    myTbaleview.dataSource=self;
    myTbaleview.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];
    [self.view addSubview:myTbaleview];
    
}

#pragma mark - uitableview
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *Identifying=@"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifying];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifying];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if ([[weekArr objectAtIndex:indexPath.row] isEqual:@"1"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }else{
    
        cell.accessoryType = UITableViewCellAccessoryNone;

    }

    NSLog(@"weekarr-------repeat-----------%@",weekArr);
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:weekArr forKey:@"weekarray"];
    [userInfo synchronize];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[weekArr objectAtIndex:indexPath.row] isEqual:@"0"]) {
        [weekArr setObject:@"1" atIndexedSubscript:indexPath.row];

    }else{
        [weekArr setObject:@"0" atIndexedSubscript:indexPath.row];
    }
    [myTbaleview reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{

    [myTbaleview release];
    [dataArray release];
    [weekArr release];
    [super dealloc];

}


@end