//
//  ViewController.h
//  Alcolator
//
//  Created by John Patrick Adapon on 9/30/14.
//  Copyright (c) 2014 John Adapon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

- (void)buttonPressed:(UIButton *)sender;

@end

