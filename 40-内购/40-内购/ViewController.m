//
//  ViewController.m
//  40-内购
//
//  Created by yhp on 2017/4/19.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>


@interface ViewController ()<SKProductsRequestDelegate>
/** 所有商品 */
@property(nonatomic,strong)NSArray* products;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 去自己的服务器请求想买商品的id
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"iapdemo.plst" ofType:nil];
    NSArray* productArray = [NSArray arrayWithContentsOfFile:filePath];
    NSArray* productIdArray = [productArray valueForKeyPath:@"productId"];
    
    // 去苹果服务器请求可卖的商品
    NSSet* productIdSet = [NSSet setWithArray:productIdArray];
    SKProductsRequest* request = [[SKProductsRequest alloc]initWithProductIdentifiers:productIdSet];
    request.delegate = self;
    [request start];
    
}

#pragma mark - <SKProductsRequestDelegate>
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    // 展示商品
    self.products = [response.products sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(SKProduct* obj1, SKProduct* obj2) {
        return [obj1.price compare:obj2.price];
    }];
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"ProductCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 取出模型
    
    
    return cell;
}


@end
