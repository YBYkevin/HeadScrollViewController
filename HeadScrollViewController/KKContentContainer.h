//
//  KKContentContainer.h
//  HeadScrollViewController
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)

#define NAVIGATION_BAR_HEGHT 44

@interface KKContentContainer : UIViewController

@property (nonatomic, strong) NSMutableArray *viewControllersContainer;

@property (nonatomic, strong) NSMutableArray *titles;

- (void)reloadData;

@end
