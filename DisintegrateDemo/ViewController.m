//
//  ViewController.m
//  DisintegrateDemo
//
//  Created by K Y on 6/22/19.
//  Copyright © 2019 KY. All rights reserved.
//

#import "ViewController.h"
#import "DisintegrateDemo-Swift.h"

#define reuseID @"cell"

@interface ViewController () {
    NSMutableArray *data;
    NSMutableArray *colors;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@interface ViewController (UITableView) <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [@[@"Red",
              @"Yellow",
              @"Orange",
              @"Blue",
              @"Pruple"] mutableCopy];
    colors = [@[UIColor.redColor,
                UIColor.yellowColor,
                UIColor.orangeColor,
                UIColor.blueColor,
                UIColor.purpleColor] mutableCopy];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                              style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    [_tableView setTableFooterView:[[UIView alloc] init]];
}


@end

@implementation ViewController (UITableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.backgroundColor = colors[row];
    cell.textLabel.text = data[row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    [colors removeObjectAtIndex:row];
    [data removeObjectAtIndex:row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView setUserInteractionEnabled:NO];
    
    // there's also weakify/strongify, but I'm not going into those
    __weak typeof(self) weakSelf = self;
    void (^completion)(void) = ^{
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableView setUserInteractionEnabled:YES];
    };
    
    [cell disintegrateWithEstimatedTriangleCount:300
                                      completion:completion];
}

@end

