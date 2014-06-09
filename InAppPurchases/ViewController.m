//
//  ViewController.m
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"

@interface ViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *purchaseButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *restoreButton;
@property (strong, nonatomic) IBOutlet UILabel *versionsLabel;

@property (strong, nonatomic) Shop *newShop;

- (IBAction)purchaseButtonPressed:(id)sender;
- (IBAction)restoreButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // check if we're running the full version
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"fullVersion"]) {
        
        self.versionsLabel.text = @"FULL VERSION";
        
    } else {
        
        self.versionsLabel.text = @"Free Version";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)purchaseButtonPressed:(id)sender {
    
    // let's make a purchase
    [self.newShop validateProductIdentifiers];
}

- (IBAction)restoreButtonPressed:(id)sender {
}

- (Shop *)newShop {
    
    if (!_newShop) {
        _newShop = [[Shop alloc]init];
        _newShop.delegate = self;
    }
    return _newShop;
}


#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0: {
            // buy button
            [self.newShop makeThePurchase];
            break;
        }
            
            
        case 1: {
            // restore button
            [self.newShop restoreThePurchase];
            
            break;
        }
          
        case 2: {
            // cancel button
            break;
        }
            
            
        default:
            break;
    }
}






@end
