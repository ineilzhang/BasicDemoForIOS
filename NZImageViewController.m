//
//  NZImageViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/9/26.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZImageViewController.h"

@interface NZImageViewController ()<UIScrollViewDelegate>
{
    UIScrollView *imageScrollView;
    UIImageView *imageView;
}

//@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
//@property (weak, nonatomic) IBOutlet UIImageView *originImageView;

@end

@implementation NZImageViewController

- (instancetype)init{
    if (self = [super init]) {
//        self.originImageView = [[UIImageView alloc]init];
//        self.imageScrollView = [[UIScrollView alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.originImageView.image = self.orginImage;
////    [self.imageScrollView addSubview:self.originImageView];
//    self.imageScrollView.delegate = self;
//    self.imageScrollView.maximumZoomScale = 5.0;
//    self.imageScrollView.minimumZoomScale = 1.0;
//    self.imageScrollView.contentSize = self.originImageView.image.size;
    
    imageScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageScrollView];
    
    imageView = [[UIImageView alloc]initWithImage:self.orginImage];
    imageView.frame = CGRectMake(0, 40, imageView.image.size.width, imageView.image.size.height);
    [imageScrollView addSubview:imageView];
    
    UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    [mySwitch addTarget:self
                 action:@selector(closeModal:)
       forControlEvents:UIControlEventValueChanged];
    [imageScrollView addSubview:mySwitch];
    
    imageScrollView.delegate = self;
    imageScrollView.maximumZoomScale = 5.0;
    imageScrollView.minimumZoomScale = 1.0;
    
    imageScrollView.contentSize = imageView.image.size;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    return self.originImageView.image;
    return imageView;
}



- (void)closeModal:(id)sender {
    UISwitch *closeSwitch = (UISwitch *)sender;
    if (!closeSwitch.isOn) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
