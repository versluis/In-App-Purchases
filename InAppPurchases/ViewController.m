//
//  ViewController.m
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "Product2.h"

@interface ViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *purchaseButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *restoreButton;
@property (strong, nonatomic) IBOutlet UILabel *versionsLabel;
@property (strong, nonatomic) IBOutlet UILabel *product2Label;

@property (strong, nonatomic) Shop *newShop;
@property (strong, nonatomic) Product2 *product2;

- (IBAction)purchaseButtonPressed:(id)sender;
- (IBAction)restoreButtonPressed:(id)sender;
- (IBAction)buyProduct2:(id)sender;

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
    
    // did the user buy the Hat?
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Product2"]) {
        self.product2Label.text = @"WE HAVE THE HAT! :-)";
    } else {
        self.product2Label.text = @"No hat here :-(";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma calling the Purchase Methods

- (IBAction)purchaseButtonPressed:(id)sender {
    
    // let's make a purchase
    [self.newShop validateProductIdentifiers];
}

- (IBAction)restoreButtonPressed:(id)sender {
    
    // restore the purchase
    [self.newShop restoreThePurchase];
}

- (IBAction)buyProduct2:(id)sender {
    
    [self.product2 validateProductIdentifiers];
}


#pragma Custom Initialisers

- (Shop *)newShop {
    
    if (!_newShop) {
        _newShop = [[Shop alloc]init];
        _newShop.delegate = self;
    }
    return _newShop;
}

- (Product2 *)product2 {
    
    if (!_product2) {
        _product2 = [[Product2 alloc]init];
        _product2.delegate = self;
    }
    return _product2;
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0: {
            // buy button - Product 1
            if (alertView.tag == 1) {
                [self.newShop makeThePurchase];
            }
            
            // buy button - Product 2
            if (alertView.tag == 2) {
                [self.product2 makeThePurchase];
            }
            
            break;
        }
            
            
        case 1: {
            // restore button - Product 1
            if (alertView.tag == 1) {
                [self.newShop restoreThePurchase];
            }
            
            // restore button - Product 2
            if (alertView.tag == 2) {
                [self.product2 restoreThePurchase];
            }
            
            
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
