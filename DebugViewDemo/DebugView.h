//
//  DebugView.h
//  DebugViewDemo
//
//  Created by Justin on 16/10/31.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugView : UIView

@property (nonatomic,assign) BOOL hidden;

@property (nonatomic,weak)   UIViewController *rootVC;

- (void)showOverWindow;

@end
