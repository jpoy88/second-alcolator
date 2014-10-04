//
//  ViewController.m
//  Alcolator
//
//  Created by John Patrick Adapon on 9/30/14.
//  Copyright (c) 2014 John Adapon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    
    // Portrait and Landscape
    //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];

    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Font
    //UIFont *calculateFont = [UIFont fontWithName:@"Times New Roman" size:17.0f];
    
    
    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //[self.calculateButton setFont:[UIFont fontWithName:@"Verdana" size:29.0f]];
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Times New Roman" size:20.0f];
    self.calculateButton.titleLabel.textColor = [UIColor whiteColor];
    //self.calculateButton.font = calculateFont;
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
    /* If you want different setup with iPad
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
    } else { }
     */
        CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width; // <--- responsive view for iPhone 3GS - iPhone 6. instead of declaring 320
        CGFloat padding = 50;
        CGFloat itemWidth = viewWidth - (padding * 2);
        CGFloat itemHeight = 44;
        
        self.beerPercentTextField.frame = CGRectMake(padding, padding + 30, itemWidth, itemHeight);
        
        
        CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
        self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
        
        CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
        
        
        //CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
        self.calculateButton.frame = CGRectMake(padding, bottomOfSlider + padding - 40, itemWidth, itemHeight);
        
        CGFloat bottomOfCalculate = CGRectGetMaxY(self.calculateButton.frame);
        self.resultLabel.frame = CGRectMake(padding, bottomOfCalculate, itemWidth, itemHeight * 2);
        self.resultLabel.backgroundColor = [UIColor greenColor];
        //CGFloat rightOfSlider = CGRectGetMaxX(self.beerCountSlider.frame);
        
        /* For Portrait
         self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding - 40, itemWidth, itemHeight * 4);
         
         self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding - 40, itemWidth, itemHeight);
         */
        
        /* For Landscape
         
         
         self.resultLabel.frame = CGRectMake(rightOfSlider + 40, bottomOfTextField + padding, itemWidth, itemHeight * 4);
         
         self.calculateButton.frame = CGRectMake(padding, bottomOfSlider + padding - 40, itemWidth, itemHeight);
         
         */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
    
- (void)textFieldDidChange:(UITextField *)sender {
    
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = [NSString string];
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    
   
    
}

- (NSString *)calculateBeerAndWine {
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    return resultText;
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    
    self.resultLabel.text = [self calculateBeerAndWine];
    
    
   
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


@end
