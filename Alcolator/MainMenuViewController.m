//
//  MainMenuViewController.m
//  Alcolator
//
//  Created by John Patrick Adapon on 10/3/14.
//  Copyright (c) 2014 John Adapon. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"

@interface MainMenuViewController ()


@property (nonatomic, weak)UIButton *wineButton;
@property (nonatomic, weak)UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void) loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views
    UIButton *buttonForWine = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *buttonForWhiskey = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Add each view
    [self.view addSubview:buttonForWine];
    [self.view addSubview:buttonForWhiskey];
    
    // Assign the views and gesture recognizer to our properties
    self.wineButton = buttonForWine;
    self.whiskeyButton = buttonForWhiskey;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine Area Command") forState:UIControlStateNormal];
    [self.wineButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.wineButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey Area Command") forState:UIControlStateNormal];
    [self.whiskeyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.whiskeyButton setBackgroundColor:[UIColor whiteColor]];
}

- (void) viewWillLayoutSubviews {
    
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat padding = 20;
    CGFloat itemWidth = (viewWidth / 3) - (padding * 2);
    CGFloat itemHeight = 50;
    
    self.wineButton.frame = CGRectMake(viewWidth / 8, viewHeight / 2, itemWidth, itemHeight);
    CGFloat sideOfWineButton = CGRectGetMaxX(self.wineButton.frame);

    self.whiskeyButton.frame = CGRectMake(sideOfWineButton + (viewWidth / 4), viewHeight / 2, itemWidth, itemHeight);
    
}


- (void) winePressed:(UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *)sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
