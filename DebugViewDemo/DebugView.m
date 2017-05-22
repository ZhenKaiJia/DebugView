//
//  DebugView.m
//  DebugViewDemo
//
//  Created by Justin on 16/10/31.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "DebugView.h"

@interface DebugView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic, strong) NSArray *actions;

@property (nonatomic,strong) UITableView *actionTableView;

@end

@implementation DebugView

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.actions = @[@"网络",@"崩溃",@"环境", @"重置",@"测试设备",@"二维码",@"H5交互",@"设备信息"];
        
        CGFloat screenWidth = ([[UIScreen mainScreen] bounds].size.width);
        CGFloat screenHeight = ([[UIScreen mainScreen] bounds].size.height);
        self.frame = CGRectMake(screenWidth, 80, 60, screenHeight - 80 * 2);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 功能区
        self.actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40)];
        self.actionTableView.delegate = self;
        self.actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.actionTableView.dataSource = self;
        self.actionTableView.rowHeight = 60;
        self.actionTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.actionTableView];
        
        // 收起按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"收起" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40);
        [self addSubview:btn];
        btn.backgroundColor = [UIColor redColor];
        
        self.hidden = YES;
    }
    return self;
}

- (void)close:(id)sender{
    self.hidden = YES;
}

- (void)setHidden:(BOOL)hidden {
    if (hidden != _hidden) {
        _hidden = hidden;
        if (!self.superview) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        if (hidden) {
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat screenWidth = ([[UIScreen mainScreen] bounds].size.width);
                CGFloat screenHeight = ([[UIScreen mainScreen] bounds].size.height);
                self.frame = CGRectMake(screenWidth, 80, self.frame.size.width, screenHeight - 80 * 2);
            }];
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat screenWidth = ([[UIScreen mainScreen] bounds].size.width);
                CGFloat screenHeight = ([[UIScreen mainScreen] bounds].size.height);
                self.frame = CGRectMake(screenWidth - self.frame.size.width, 80, self.frame.size.width, screenHeight - 80 * 2);
            }];
        }
    }
}
- (void) handleSwipeFromRight:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:recognizer.view];
    if (point.y < 20) {
        self.hidden = NO;
    }
}

- (void) handleSwipeFromLeft:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:recognizer.view];
    if (point.y < 20) {
        self.hidden = YES;
    }
}
- (void) showOverWindow {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(100, 0, ([[UIScreen mainScreen] bounds].size.width) - 100, 20)];
    // iOS9 will crash if not have this sentence.
    self.window.rootViewController = self.rootVC;
    self.window.windowLevel = UIWindowLevelStatusBar + 10;
    self.window.hidden = NO;
    UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.window addGestureRecognizer:recognizer1];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.window addGestureRecognizer:recognizer2];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = self.window.frame;
    tipLabel.text = @"左滑、右滑";
    tipLabel.font = [UIFont systemFontOfSize:11];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.backgroundColor = [UIColor redColor];
    [self.window addSubview:tipLabel];
}

#pragma mark - tableview
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actions.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"DebugActionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.actions objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
