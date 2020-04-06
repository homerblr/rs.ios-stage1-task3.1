#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end
@implementation ViewController
    
static CGPoint const origin = {20, 100};
static CGSize const defaultLabelSize = {100 , 50};
static int const offset = 25;
static int const fontSize = 20;
NSString* range = @"0..255";
NSString* empty = @"";


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUserInterface];
    [self setupAccessibility];
    
}

- (void) setupAccessibility{
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

- (void) setupUserInterface{
    UILabel *resultColor = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, defaultLabelSize.width + offset, defaultLabelSize.height)];
    _labelResultColor = resultColor;
    resultColor.text = @"Color";
     [self.view addSubview:resultColor];
    UIView *resultColorView = [[UIView alloc] initWithFrame:CGRectMake(origin.x + defaultLabelSize.width +offset, origin.y, 2* defaultLabelSize.width, defaultLabelSize.height)];
    _viewResultColor = resultColorView;
    resultColorView.layer.borderColor = [UIColor clearColor].CGColor;
    resultColorView.layer.borderWidth = 2;
    resultColorView.layer.cornerRadius = 4;
    [self.view addSubview:resultColorView];
    UILabel *labelRed = [[UILabel alloc] initWithFrame:CGRectMake(origin.x , origin.y + resultColor.bounds.size.height + offset, defaultLabelSize.width - offset, defaultLabelSize.height)];
    _labelRed = labelRed;
    labelRed.text = @"RED";
    [labelRed setFont:[UIFont systemFontOfSize:fontSize]];
    [self.view addSubview:labelRed];
    UITextField *redField = [[UITextField alloc] initWithFrame:CGRectMake(origin.x + defaultLabelSize.width - offset, origin.y + defaultLabelSize.height +offset, 2*(defaultLabelSize.width + offset), defaultLabelSize.height)];
    _textFieldRed = redField;
    redField.placeholder =  range;
    redField.layer.borderColor = [UIColor blackColor].CGColor;
    redField.layer.borderWidth = 2;
    redField.layer.cornerRadius = 4;
    [self.view addSubview:redField];
    redField.delegate = self;
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(origin.x , origin.y + 2*(resultColor.bounds.size.height + offset), defaultLabelSize.width - offset, defaultLabelSize.height)];
    _labelGreen = greenLabel;
    greenLabel.text = @"GREEN";
    [greenLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [self.view addSubview:greenLabel];
    UITextField *greenField = [[UITextField alloc] initWithFrame:CGRectMake(origin.x + defaultLabelSize.width - offset, origin.y + 2*(defaultLabelSize.height +offset), 2*(defaultLabelSize.width + offset), defaultLabelSize.height)];
    _textFieldGreen = greenField;
    greenField.placeholder = range;
    greenField.textAlignment = NSTextAlignmentLeft;
    greenField.layer.borderColor = [UIColor blackColor].CGColor;
    greenField.layer.borderWidth = 2;
    greenField.layer.cornerRadius = 4;
    [self.view addSubview:greenField];
    greenField.delegate = self;
    
    UILabel *blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(origin.x , origin.y + 3*(resultColor.bounds.size.height + offset), defaultLabelSize.width - offset, defaultLabelSize.height)];
    _labelBlue = blueLabel;
    blueLabel.text = @"BLUE";
    [blueLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [self.view addSubview:blueLabel];
    UITextField *blueField = [[UITextField alloc] initWithFrame:CGRectMake(origin.x + defaultLabelSize.width - offset, origin.y + 3*(defaultLabelSize.height +offset), 2*(defaultLabelSize.width + offset), defaultLabelSize.height)];
    _textFieldBlue = blueField;
    blueField.placeholder = range;
    blueField.layer.borderColor = [UIColor blackColor].CGColor;
    blueField.layer.borderWidth = 2;
    blueField.layer.cornerRadius = 4;
    [self.view addSubview:blueField];
    blueField.delegate = self;
    
    UIButton *processButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttonProcess = processButton;
    [processButton setFrame:CGRectMake(self.view.center.x-defaultLabelSize.width/2, self.view.center.y, defaultLabelSize.width, defaultLabelSize.height)];
    [processButton setTitle:@"Process" forState:UIControlStateNormal];
    [processButton setTintColor:[UIColor systemBlueColor]];
    [processButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [processButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:processButton];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textFieldRed endEditing:YES];
    [self.textFieldGreen endEditing:YES];
    [self.textFieldBlue endEditing:YES];
    if ([self.labelResultColor.text isEqualToString:@"Error"]) {
        self.labelResultColor.text = @"Color";
    }
   }

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL) withError{
    if ([self.labelRed.text length] == 0 || [self.labelGreen.text length] == 0 || [self.labelBlue.text length] == 0 || [self.textFieldRed.text intValue] >255 || [self.textFieldRed.text intValue] < 0 || [self.textFieldGreen.text intValue] > 255 || [self.textFieldGreen.text intValue] < 0  || [self.textFieldBlue.text intValue] >255 || [self.textFieldBlue.text intValue] < 0  || ![self.textFieldRed.text isEqualToString:[[NSString alloc] initWithFormat:@"%i", [self.textFieldRed.text intValue]]] || ![self.textFieldGreen.text isEqualToString:[[NSString alloc] initWithFormat:@"%i", [self.textFieldGreen.text intValue]]] || ![self.textFieldBlue.text isEqualToString:[[NSString alloc] initWithFormat:@"%i", [self.textFieldBlue.text intValue]]] || [self.textFieldRed.text isEqualToString:empty] || [self.textFieldGreen.text isEqualToString:empty] || [self.textFieldBlue.text isEqualToString:empty]) {
        return YES;
    }
    return NO;
}

-(void) buttonTapped:(id)sender{
    [self.textFieldRed resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
    
    if ([self withError]) {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
        NSLog(@"color %@", self.viewResultColor.backgroundColor);
    }else{
        double r = [self.textFieldRed.text floatValue];
        double g = [self.textFieldGreen.text floatValue];
        double b = [self.textFieldBlue.text floatValue];
        self.viewResultColor.backgroundColor = [UIColor colorWithRed: r/255 green:g/255 blue: b/255 alpha: 1.0];
        self.labelResultColor.text = [self hexStringForColor:self.viewResultColor.backgroundColor];
    }
    self.textFieldRed.text = empty;
    self.textFieldGreen.text = empty;
    self.textFieldBlue.text = empty;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.labelResultColor.text = @"Color";
    return YES;
}
 
- (NSString *)hexStringForColor:(UIColor *)color {
      const CGFloat *components = CGColorGetComponents(color.CGColor);
      return [NSString stringWithFormat:@"0x%02X%02X%02X", (int)(components[0] * 255), (int)(components[1] * 255), (int)(components[2] * 255)]; ;
}
@end
