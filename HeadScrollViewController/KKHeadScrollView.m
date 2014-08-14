//
//  KKHeadScrollView.m
//  HeadScrollViewController
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "KKHeadScrollView.h"

#define BUTTON_START_TAG 100

#define BUTTON_PADDING 15

#define BUTTON_WIDTH  80

#define BUTTON_HEIGHT 40

@implementation KKHeadScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor purpleColor];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
    }
    return self;
}


-(void)loadContentView
{
    if ([self.titles count] == 0 || !self.titles) {
        return;
    }
    
    __block int btnX = BUTTON_PADDING * 2;
    
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        CGSize buttonSize = [title boundingRectWithSize:CGSizeMake(BUTTON_WIDTH, BUTTON_HEIGHT)
                                                options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}
                                                context:nil].size;
        
        int buttonWidth = buttonSize.width;
        
        button.frame = CGRectMake(btnX, 0, buttonWidth, BUTTON_HEIGHT);
        btnX += buttonWidth + BUTTON_PADDING*2;
        
        button.tag = idx + BUTTON_START_TAG;
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self.viewsContainer addObject:button];
        
    }];
    
    self.contentSize = CGSizeMake(btnX, 0);
}


-(NSMutableArray *)viewsContainer
{
    if (!_viewsContainer) {
        _viewsContainer = [NSMutableArray array];
    }
    return _viewsContainer;
}

-(NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}


#pragma mark -
#pragma mark - Button Action
-(void)didClickHeadButtonAction:(UIButton*)btn
{
    NSInteger selectIndex = btn.tag - BUTTON_START_TAG;
    if (selectIndex == self.currentIndex)  return;
    
    [self adjustHeadScrollViewFromIndex:selectIndex];
    
}

#pragma mark -
#pragma mark - Handle ScrollView

- (void)adjustHeadScrollViewFromIndex:(NSInteger)selectIndex
{
    [self handleButtonSelectIndex:selectIndex];
    
    CGPoint contentOffsetPoint = CGPointMake(0, 0);
    
    UIButton *button = (UIButton*)[self.viewsContainer objectAtIndex:selectIndex];
    CGFloat buttonOriginX = button.frame.origin.x;
    CGFloat buttonWidth = button.frame.size.width;
    contentOffsetPoint.x = buttonOriginX - (CGRectGetWidth(self.bounds) - buttonWidth)/2;
    
    if (contentOffsetPoint.x < 0) {
        contentOffsetPoint.x = 0;
    }
    else if (contentOffsetPoint.x >= self.contentSize.width - CGRectGetWidth(self.bounds))
    {
        contentOffsetPoint.x = self.contentSize.width - CGRectGetWidth(self.bounds);
    }
    
    [self setContentOffset:contentOffsetPoint animated:YES];
}

#pragma mark -
#pragma mark - Handle Button Status
- (void)handleButtonSelectIndex:(NSInteger)selectIndex
{
    [self clearButtonSelectStatus:self.currentIndex];
    self.currentIndex = selectIndex;
    [self setButtonSelectStatus:self.currentIndex];
    
}

-(void)clearButtonSelectStatus:(NSInteger)index
{
    [self setButtonIndex:index selectStatus:NO];
}

-(void)setButtonSelectStatus:(NSInteger)index
{
    [self setButtonIndex:index selectStatus:YES];
}

-(void)setButtonIndex:(NSInteger)buttonIndex selectStatus:(BOOL)status
{
    UIButton *button = (UIButton*)[self.viewsContainer objectAtIndex:buttonIndex];
    button.selected = status;
}

- (void)dealloc
{
    self.titles = nil;
    self.viewsContainer = nil;
}

@end
