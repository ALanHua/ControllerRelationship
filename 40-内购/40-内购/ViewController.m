//
//  ViewController.m
//  40-内购
//
//  Created by yhp on 2017/4/19.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>


@interface ViewController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 添加观察者
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 移除观察者
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - 恢复购买
- (IBAction)restore:(id)sender {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - <SKProductsRequestDelegate>
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    // 展示商品
    self.products = [response.products sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(SKProduct* obj1, SKProduct* obj2) {
        return [obj1.price compare:obj2.price];
    }];
    // 刷新表格
    [self.tableView reloadData];
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
    SKProduct* product = self.products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"价格：%@",product.price];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    SKProduct* product = self.products[indexPath.row];
    // 购买商品
    [self buyProduct:product];
}

#pragma mark - 购买商品
-(void)buyProduct:(SKProduct*)product
{
    // 1,创建票据
    SKPayment* payment = [SKPayment paymentWithProduct:product];
    // 2，将票据加入到队列中
    [[SKPaymentQueue defaultQueue]addPayment:payment];
}

#pragma mark - <SKPaymentTransactionObserver>

/**
 交易发生改变就会调用该方法
 @param queue 队列
 @param transactions 交易
 */
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    /**
     SKPaymentTransactionStatePurchasing, 正在购买
     SKPaymentTransactionStatePurchased,  已经购买
     SKPaymentTransactionStateFailed,     购买失败
     SKPaymentTransactionStateRestored,   恢复购买
     SKPaymentTransactionStateDeferred    小孩购买
     */
    for (SKPaymentTransaction* transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"正在购买");
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"购买成功，商品给用户");
                // 将交易从队列从移除
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                 NSLog(@"购买失败");
                // 将交易从队列从移除
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"恢复购买,对应商品给用户");
                // 将交易从队列从移除
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"未决定");
                break;
            default:
                break;
        }
    }
}

@end
