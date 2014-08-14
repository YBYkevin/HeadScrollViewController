//
//  KKContentContainer.m
//  HeadScrollViewController
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//


#import "KKContentContainer.h"
#import "KKHeadScrollView.h"

@interface KKContentContainer ()<UIScrollViewDelegate>

@property(nonatomic,strong) KKHeadScrollView *headScrollView;

@property(nonatomic,strong) UIScrollView *contentScrollView;

@end

@implementation KKContentContainer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpViews];
    [self reloadData];
    
}

#pragma mark -
#pragma mark - Data
- (void)reloadData
{
    [self.headScrollView.titles addObjectsFromArray:self.titles];
    [self.headScrollView loadContentView];
    
    self.headScrollView.currentIndex = 0;
    [self.headScrollView setButtonSelectStatus:self.headScrollView.currentIndex];
    
    [self.viewControllersContainer enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        CGRect viewControllerFrame = self.contentScrollView.bounds;
        viewControllerFrame.origin.x = idx * CGRectGetWidth(self.contentScrollView.bounds);
        [viewController.view setFrame:viewControllerFrame];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        [self.contentScrollView addSubview:viewController.view];
    }];
    
    self.contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.contentScrollView.bounds) * self.viewControllersContainer.count, 0);
    
    [self startObservingHeadScrollView];
}

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}


#pragma mark -
#pragma mark - Adapter View Frame
//适配IOS7 && 没有NavigationBar的情况
- (CGRect)headViewFrame
{
    CGFloat originY = [self.navigationController.navigationBar isHidden] ? IOS7_STATUS_BAR_HEGHT : IOS7_STATUS_BAR_HEGHT + NAVIGATION_BAR_HEGHT;
    
    CGRect headViewFrame;
    
    headViewFrame = CGRectMake(0, originY, 320, 40);
    
    return headViewFrame;
}

- (CGRect)contentViewFrame
{
    CGFloat height = [self.navigationController.navigationBar isHidden] ? 464 + NAVIGATION_BAR_HEGHT : 464;
    
    CGRect contentViewFrame;
    
    contentViewFrame = CGRectMake(0, [self headViewFrame].origin.y +  [self headViewFrame].size.height, 320, height);
    
    return contentViewFrame;
}


#pragma mark -
#pragma mark - Views

- (void)setUpViews
{
    [self.view addSubview:self.headScrollView];
    [self.view addSubview:self.contentScrollView];
}

- (KKHeadScrollView *)headScrollView
{
    if (!_headScrollView) {
        _headScrollView = [[KKHeadScrollView alloc] initWithFrame:[self headViewFrame]];
    }
    return _headScrollView;
}

- (UIScrollView*)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:[self contentViewFrame]];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}



#pragma mark -
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger selectIndex = [self getCurrentIndexWithScrollView:scrollView];
    [self.headScrollView adjustHeadScrollViewFromIndex:selectIndex];
    
}

#pragma mark -
#pragma mark - Handle ContentScrollView
- (void)adjustContentScrollViewFromIndex:(NSInteger)selectIndex
{
    [self.contentScrollView setContentOffset:CGPointMake(selectIndex * CGRectGetWidth(self.contentScrollView.bounds), 0) animated:NO];
}

- (NSInteger)getCurrentIndexWithScrollView:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    NSUInteger page = floor(scrollView.contentOffset.x / pageWidth) ;
    return page;
}

#pragma mark -
#pragma mark - KVO

- (void)startObservingHeadScrollView
{
    [self.headScrollView addObserver:self forKeyPath:@"currentIndex" options: NSKeyValueObservingOptionNew context:nil];
}

- (void)stopObservingHeadScrollView
{
    [self.headScrollView removeObserver:self forKeyPath:@"currentIndex"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"currentIndex"]) {
        
        NSInteger newInteger = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        [self adjustContentScrollViewFromIndex:newInteger];
    }
}


-(void)dealloc
{
    [self stopObservingHeadScrollView];
    self.headScrollView = nil;
    self.contentScrollView = nil;
    self.titles = nil;
    self.viewControllersContainer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
