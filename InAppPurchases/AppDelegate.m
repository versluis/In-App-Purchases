//
//  AppDelegate.m
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // add StoreKit Observer
    [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

#pragma mark - StoreKit Methods

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased: {
                
                // purchase went well
                // unlock the full version
                [self unlockFullVersion];
                
                // finish the transaction
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                
                // save the receipt
                [self saveReceipts];
                
                // tell the user this went well
                NSLog(@"Purchase was successful!");
                
                break;
            }
                
            case SKPaymentTransactionStatePurchasing: {
                
                // currently purchasing
                break;
            }
                
            case SKPaymentTransactionStateRestored: {
                
                // restored
                
                // unlock full version
                [self unlockFullVersion];
                
                // finish transaction
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                
                // tell the user
                NSLog(@"Restore was successful!");
                
                break;
            }
                
            case SKPaymentTransactionStateFailed: {
                
                // this didn't work so well
                NSLog(@"Restore was NOT sucessfull :-(");
                
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - Store Methods

- (void)unlockFullVersion {
    
    // save YES to User Defaults
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"fullVersion"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)saveReceipts {
    
    // save your original receipts in iCloud
    // upon restore you can compare the new receipt to the original
    // however if you don't have the data anymore this makes little sense
    // just thought I'd pass on the Apple Reccomendation here...
}

- (void)validateReceipt {
    
    // receipt validation goes here
}









@end
