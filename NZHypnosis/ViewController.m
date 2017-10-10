//
//  ViewController.m
//  NZHypnosis
//
//  Created by Neil Zhang on 2017/8/3.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "ViewController.h"
#import "HypnosisView.h"
#import "PrefixHeader.pch"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) HypnosisView *firstView;

@property (nonatomic,strong) HypnosisView *secondView;

@property (nonatomic,strong) UITextField *txtField;

@property (nonatomic,copy) NSString *str;

@property (nonatomic,strong) UILabel *message;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, kWidth, kHeight - 64);
    self.tabBarItem.title = @"Hypnosis";
    self.tabBarItem.image = [UIImage imageNamed:@"Hypno"];
    return self;
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    CGRect screenRect = self.view.frame;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
    self.firstView = [[HypnosisView alloc]initWithFrame:screenRect];
    self.secondView = [[HypnosisView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 20, self.view.frame.size.width, self.view.frame.size.height)];
//    view.center = self.view.center;
    UIScrollView *scrollView =
        [[UIScrollView alloc]initWithFrame:screenRect];
    scrollView.contentSize = bigRect.size;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView addSubview:self.firstView];
    [scrollView addSubview:self.secondView];
    
    
    //add segment control
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"Red",@"Blue",@"green"]];
    [control addTarget:self
                action:@selector(tapAction:)
      forControlEvents:UIControlEventValueChanged];
    control.frame = CGRectMake(100, 40, 120, 20);
    
    
    //add text field
    self.txtField = [[UITextField alloc]initWithFrame:CGRectMake(80, 80, 160, 40)];
    self.txtField.borderStyle = UITextBorderStyleRoundedRect;
    self.txtField.placeholder = @"test";
    self.txtField.returnKeyType = UIReturnKeyDone;
    self.txtField.delegate = self;
    
    [self.view addSubview:scrollView];
    [self.view addSubview:control];
    [self.view addSubview:self.txtField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapAction:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:{
            self.firstView.cycleColor = [UIColor redColor];
        }
            break;
        case 1:{
            self.firstView.cycleColor = [UIColor blueColor];
        }
            break;
        case 2:{
            self.firstView.cycleColor = [UIColor greenColor];
        }
            break;
        default:
            self.firstView.cycleColor = [UIColor clearColor];
            break;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtField resignFirstResponder];
    [self drawHynoMessage:textField.text];
    return YES;
}

- (void)drawHynoMessage:(NSString *)message
{
    for (int i = 0; i < 20 ; i++) {
        UILabel *hynoMessageLabel = [[UILabel alloc]init];
        hynoMessageLabel.text = message;
        NSInteger width = self.view.bounds.size.width - hynoMessageLabel.bounds.size.width;
        NSInteger x = arc4random() % width;
        NSInteger height = self.view.bounds.size.height - hynoMessageLabel.bounds.size.height;
        NSInteger y = arc4random() % height;
        hynoMessageLabel.backgroundColor = [UIColor blueColor];
        hynoMessageLabel.textColor = [UIColor redColor];
        [hynoMessageLabel sizeToFit];
        hynoMessageLabel.center = CGPointMake(x, y);
        [self.view addSubview:hynoMessageLabel];
    }
}

@end
