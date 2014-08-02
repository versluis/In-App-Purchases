//
//  Product2.h
//  InAppPurchases
//
//  Created by Jay Versluis on 06/06/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import StoreKit;

@interface Product2 : NSObject <SKProductsRequestDelegate>

@property (nonatomic, strong) NSArray *allProducts;
@property (nonatomic, strong) SKProduct *thisProduct;
@property (weak) id delegate;

- (void)validateProductIdentifiers;
- (void)makeThePurchase;
- (void)restoreThePurchase;

@end
