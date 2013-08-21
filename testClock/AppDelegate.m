//
//  AppDelegate.m
//  testClock
//
//  Created by l_ch_g on 13-6-19.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"
@implementation AppDelegate
@synthesize timer=_timer;


- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //    本地通知
    UILocalNotification *locationNoti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNoti) {
        
        if ([[locationNoti.userInfo objectForKey:@"isSleep"] isEqual:@"1"]) {
            if (!_timer) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0*60*10 target:self selector:@selector(DoNoti) userInfo:nil repeats:YES];

            }
            
        }
        application.applicationIconBadgeNumber = 0;
        

        
    }
    
    WebViewController *web = [[WebViewController alloc]init];
    
    RootViewController *rootController = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootController];
    self.window.rootViewController = web;
    nav.navigationBarHidden=YES;
    [rootController release];
    [nav release];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIImageView *splashScreen = [[[UIImageView alloc] initWithFrame:self.window.bounds] autorelease];
    splashScreen.image = [UIImage imageNamed:@"Default"];
    [self.window addSubview:splashScreen];
    
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
        splashScreen.layer.transform = transform;
        splashScreen.alpha = 0.0;
    } completion:^(BOOL finished) {
        [splashScreen removeFromSuperview];
    }];
    return YES;
}
-(void)DoNoti
{
    UIAlertView *alertNoti = [[UIAlertView alloc]initWithTitle:@"提示" message:@"小歇" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"小睡", nil];
    alertNoti.tag=600;
    [alertNoti show];
    [alertNoti release];
    //发送通知
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    
    if (notification!=nil) {
        NSLog(@"本地通知----------didReceiveLocalNotification----------OK-----nil--");

        
        NSDate *now=[NSDate new];
        
        notification.fireDate=[now dateByAddingTimeInterval:60*10];//10秒后通知
        
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        notification.timeZone= GTMzone;
        
        notification.applicationIconBadgeNumber=0; 
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *myURL=[user stringForKey:@"myurl"];
        if (myURL==nil) {
            notification.soundName =@"lx.caf";
        }else{
            notification.soundName = myURL;
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];      
        
    }
    
    [notification release];


}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark - NOti

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"本地通知----------didReceiveLocalNotification----------OK----appp---");

    
    if (notification) {
        
        if ([[notification.userInfo objectForKey:@"isSleep"] isEqual:@"1"]) {
            if (!_timer) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0*60*10 target:self selector:@selector(DoNoti) userInfo:nil repeats:YES];
            }
            
        }
        application.applicationIconBadgeNumber = 0;
        
        NSLog(@"本地通知----------didReceiveLocalNotification----------OK-----apppp1111111--");
        
        
    }
    
}
#pragma mark - uialertviewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag==600 || alertView.tag == 601) {
        if (buttonIndex==0) {
            
            if (_timer) {
                if ([self.timer isValid]) {
                    [self.timer invalidate];
                    _timer =nil;
                }
            }
        }
    }
    

}
-(void)didPresentAlertView:(UIAlertView *)alertView
{

    if (alertView.tag == 600 || alertView.tag == 601) {
        [self performSelector:@selector(DismissAlert:) withObject:alertView afterDelay:1.0*60*9];

    }

}
-(void)DismissAlert:(UIAlertView *)alert
{
    if (alert.visible == YES) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }


}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
