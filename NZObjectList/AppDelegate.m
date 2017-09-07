//
//  AppDelegate.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NZItemStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *main = [[ViewController alloc]init];
    UINavigationController *rootVC = [[UINavigationController alloc]initWithRootViewController:main];
    self.window.rootViewController = rootVC;
    self.window.backgroundColor  = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
#pragma mark - write text data to file
    NSError *err;
    NSString *text = @"Hello world!";
    NSString *textPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *textFilePath = [textPath stringByAppendingPathComponent:@"text.txt"];
    BOOL *myEssay = [text writeToFile:textFilePath
                           atomically:YES
                             encoding:NSUTF8StringEncoding
                                error:&err];
    if (!myEssay) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Write Failed!"
                                                                       message:[err localizedDescription]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alert addAction:defaultAction];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
#pragma mark - read text data 
    
    NSString *readText = [NSString stringWithContentsOfFile:textFilePath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&err];
    if (readText) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Read Successfully!"
                                                                       message:readText
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alert addAction:defaultAction];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([[NZItemStore shareManage] saveChanges]) {
        NSLog(@"save changes successfully!");
    }else{
        NSLog(@"save changes failed!");
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
