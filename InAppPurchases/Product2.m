//
//  Product2.m
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "Product2.h"

@implementation Product2

- (NSArray *)allProducts {
    
    // replace the Product ID's with your own
    // and don't forget to replace the Bundle ID too!
    if (!_allProducts) {
        _allProducts = @[@"com.versluis.buyme.hat"];
    }
    return _allProducts;
}

#pragma mark - Public Methods

- (void)validateProductIdentifiers {
    
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithArray:self.allProducts]];
    request.delegate = self;
    [request start];
}

- (void)makeThePurchase {
    
    // ask App Store to take a payment
    SKPayment *payment = [SKPayment paymentWithProduct:self.thisProduct];
    [[SKPaymentQueue defaultQueue]addPayment:payment];
}

- (void)restoreThePurchase {
    
    // ask App Store to restore
    [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
    
}


#pragma mark - SKProductsRequest Delegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    // grab a reference to our product
    self.thisProduct = response.products.firstObject;
    
    if ([SKPaymentQueue canMakePayments]) {
        
        // yes we can buy stuff
        [self displayStoreUI];
        
    } else {
        
        // in app purchases are disabled in Settings
        [self cantBuyAnything];
    }
}

- (void)displayStoreUI {
    
    // create number formatter
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = self.thisProduct.priceLocale;
    NSString *price = [NSString stringWithFormat:@"Buy this for %@", [formatter stringFromNumber:self.thisProduct.price]];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:self.thisProduct.localizedTitle message:self.thisProduct.localizedDescription delegate:self.delegate cancelButtonTitle:price otherButtonTitles:@"Restore Purchases", @"Maybe Later...", nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)cantBuyAnything {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't Buy Anything" message:@"In-App Purcahses are disabled on this device. Sorry :-(" delegate:nil cancelButtonTitle:@"What a shame!" otherButtonTitles:nil, nil];
    [alertView show];
}








@end
