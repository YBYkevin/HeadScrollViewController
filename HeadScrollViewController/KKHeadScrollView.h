//
//  KKHeadScrollView.h
//  HeadScrollViewController
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKHeadScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) NSMutableArray *viewsContainer;

@property (nonatomic, assign) NSInteger currentIndex;


- (void)loadContentView;

- (void)adjustHeadScrollViewFromIndex:(NSInteger)selectIndex;

- (void)clearButtonSelectStatus:(NSInteger)index;

- (void)setButtonSelectStatus:(NSInteger)index;

@end
