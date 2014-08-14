//
//  ContentViewController.m
//  HeadScrollViewController
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0f
                                                green:(arc4random() % 255)/255.0f
                                                 blue:(arc4random() % 255)/255.0f
                                                alpha:1.0];
    
    UILabel *contentlabel = [[UILabel alloc] init];
    [contentlabel setFrame:CGRectMake((self.view.bounds.size.width - 150)/2, self.view.bounds.size.height/2, 150, 30)];
    [contentlabel setText:self.title];
    [contentlabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:contentlabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
