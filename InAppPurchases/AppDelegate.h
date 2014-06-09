//
//  AppDelegate.h
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@import StoreKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) UIWindow *window;

@end
