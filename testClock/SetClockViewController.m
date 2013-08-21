

#import "SetClockViewController.h"
#import "RpeatViewController.h"
#import "FMDatabase.h"
@interface SetClockViewController ()

@end

@implementation SetClockViewController
@synthesize myTableview;
@synthesize dataArray;
@synthesize ClockDataDict;
@synthesize myDatePicker;
@synthesize path;

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
    [self dismissModalViewControllerAnimated:YES];
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
    [btnCancel setImage:[UIImage imageNamed:@"btn_quxiao.png"] forState:UIControlStateNormal];
    [topView addSubview:btnCancel];
    [btnCancel release];
    
    UIButton *btnDone = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnDone.frame = CGRectMake(250, 0, 70, 44);
    [btnDone setImage:[UIImage imageNamed:@"btn_wancheng.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnClockDone) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btnDone];
    [btnDone release];

    
}
-(void)refreshTableDate
{
    refreshDone=YES;
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSLog(@"userInfo objectForKey:----refe---%@",[userInfo objectForKey:@"weekarray"]);
    
    [self.myTableview reloadData];
    NSLog(@"%@",myTableview);

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1];

    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"CLOCK.db"];

      

    //  设置时间
    myDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height-216 , 320, 300)];
    [myDatePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    [myDatePicker setDate:[NSDate date] animated:YES];
    
    myDatePicker.datePickerMode=UIDatePickerModeTime;
    [myDatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:myDatePicker];
    [myDatePicker release];
    
    myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, Height-44-216) style:UITableViewStyleGrouped];
    myTableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    myTableview.delegate=self;
    myTableview.dataSource=self;
    [self.view addSubview:myTableview];
    
    //56 84 135
    
    [self topview];
    
    
}
#pragma mark- UIDatePicker 事件
-(void) datePickerChanged:(UIDatePicker *)paramDatePicker{
  //  if ([paramDatePicker isEqual:self.myDatePicker]){
        NSLog(@"Selected date = %@", paramDatePicker.date);
  //  }
    NSDate *selected = [myDatePicker date];
    NSLog(@"myDatePicker-----selected----------%@",selected);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *theDate = [dateFormat stringFromDate:selected];
    
    NSString *message = [[NSString alloc] initWithFormat:@"The date and time you selected is:%@",theDate];
    NSLog(@"message--------%@",message);

}
//设置闹钟完成
-(void)btnClockDone
{
    //设置时间
    static  int flag=0;
    NSString *strFlag = [NSString stringWithFormat:@"%d",flag++];
    NSLog(@"strflat-------------%@",strFlag);
    NSDate *selected = [myDatePicker date];
    NSLog(@"myDatePicker-----selected----------%@",selected);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *theDate = [dateFormat stringFromDate:selected];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString *timeDate = [dateFormat stringFromDate:selected];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *datehm=[dateFormat stringFromDate:selected];

    NSLog(@"thedate-------------%@--------timefdate----------%@",theDate,timeDate);
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [userInfo objectForKey:@"weekarray"];
    NSLog(@"arr----------------set-----------%@",arr);
    NSString *SWon=[userInfo objectForKey:@"isSleepLittle"];
    
    NSLog(@"swon---------------%@",SWon);
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    BOOL res=[db open];//打开数据库 支持类型nsstring nsnumber nsdata
    if (res==NO) {
        NSLog(@"open error");
        return;
    }
    res = [db executeUpdate:@"insert into CLOCKDATE values(?,?,?,?,?,?,?,?,?,?,?,?,?)",strFlag,timeDate,theDate,SWon,arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],@"0",datehm];
    if (res == NO) {
        NSLog(@"insert error");
    }
    [db close];
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];

}
-(void)viewDidAppear:(BOOL)animated
{
    refreshDone=YES;

    [super viewDidAppear:animated];
    [myTableview reloadData];
    
}
#pragma mark -Tableview
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *Centifier=@"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Centifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Centifier] autorelease];;
    };
    if (indexPath.row == 0) {
        cell.textLabel.text=@"重复";
        for (UILabel *label in [cell subviews]) {
            if (label.tag== 123) {
                [label removeFromSuperview];
                break;
            }
        }
        
        
        UILabel *pLable = [[UILabel alloc] initWithFrame:CGRectMake(250-200, 11, 230, 25)];
        pLable.textAlignment   = NSTextAlignmentRight;
        pLable.backgroundColor = [UIColor clearColor];
        pLable.textColor =[UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1];

        pLable.tag = 123;
        [cell addSubview:pLable];
        [pLable release];
        
        if (refreshDone ==YES) {
            NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            if ([[userInfo objectForKey:@"weekarray"] isKindOfClass:[NSMutableArray class]]) {
            
                pLable.text = [SetClockViewController getNameForRepeat:[userInfo objectForKey:@"weekarray"]];
                NSLog(@"plabel.text------------%@",pLable.text);
            }else{
            
            pLable.text=@"永不";
            }

        }
        
    }
    if (indexPath.row == 1) {
         cell.textLabel.text=@"间歇";
        
        for (UISwitch *lable in [cell subviews]) {
            if (lable.tag == 123) {
                [lable removeFromSuperview];
                break;
            }
        }

        CellSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(230, 7, 90, 30)];
        CellSwitch.tag=123;
        [cell addSubview:CellSwitch];
        [CellSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [CellSwitch setOn:NO];
        [CellSwitch release];
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:@"0" forKey:@"isSleepLittle"];
        [userInfo synchronize];
    }

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    RpeatViewController *repatController = [[RpeatViewController alloc]initWithNibName:@"RpeatViewController" bundle:nil];
        repatController.setClock=self;
        [self presentViewController:repatController animated:YES completion:^(void){}];
        [repatController release];
    }
}

+(NSString*)getNameForRepeat:(NSMutableArray*)Data
{
    NSString *pString = @"";
    bool isWork = false;
    if ([Data[0] isEqual:@"1"] && [Data[1] isEqual:@"1"] && [Data[2] isEqual:@"1"] && [Data[3] isEqual:@"1"] && [Data[4] isEqual:@"1"] && [Data[5] isEqual:@"0"] && [Data[6] isEqual:@"0"]) {
        pString = @"工作日";
    }
    else if([Data[0] isEqual:@"0"] && [Data[1] isEqual:@"0"] && [Data[2] isEqual:@"0"] && [Data[3] isEqual:@"0"] && [Data[4] isEqual:@"0"] && [Data[5] isEqual:@"1"] && [Data[6] isEqual:@"1"])
    {
        pString = @"周末";
    }
    else if([Data[0] isEqual:@"1"] && [Data[1] isEqual:@"1"] && [Data[2] isEqual:@"1"] && [Data[3] isEqual:@"1"] && [Data[4] isEqual:@"1"] && [Data[5] isEqual:@"1"] && [Data[6] isEqual:@"1"]){
        pString = @"每天";
    }
    else if([Data[0] isEqual:@"0"] && [Data[1] isEqual:@"0"] && [Data[2] isEqual:@"0"] && [Data[3] isEqual:@"0"] && [Data[4] isEqual:@"0"] && [Data[5] isEqual:@"0"] && [Data[6] isEqual:@"0"]){
        pString = @"不重复";
    }
    else{
        if ([Data[0] isEqual:@"1"]) {
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周一"];
            isWork = true;
        }
        if ([Data[1] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周二"];
            isWork = true;
        }
        if ([Data[2] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周三"];
            isWork = true;
        }
        if ([Data[3] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周四"];
            isWork = true;
        }
        if ([Data[4] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周五"];
            isWork = true;
        }
        if ([Data[5] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周六"];
            isWork = true;
        }
        if ([Data[6] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"周日"];
            isWork = true;
        }
    }
    
    
    return pString;
}


-(void)switchAction :(id)sender
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (CellSwitch.on==YES) {
        [userInfo setObject:@"1" forKey:@"isSleepLittle"];
    }
    else{
        [userInfo setObject:@"0" forKey:@"isSleepLittle"];
    }
    [userInfo synchronize];
}

-(void)dealloc
{   

    [super dealloc];
    [myTableview release];
    [dataArray release];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 
 
 NSDate *selected = [datePicker date];
 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
 [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
 NSString *theDate = [dateFormat stringFromDate:selected];
 
 NSString *message = [[NSString alloc] initWithFormat:
 @"The date and time you selected is:%@",theDate];

 
 */

@end










































