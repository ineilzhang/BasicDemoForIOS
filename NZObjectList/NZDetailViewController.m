//
//  NZDetailViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZDetailViewController.h"
#import "NZChangeDateViewController.h"
#import "NZItemStore.h"
#import "NZImageStore.h"
#import "PrefixHeader.pch"

@interface NZDetailViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property (weak, nonatomic) IBOutlet UITextField *serialTextField;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic,strong) NZChangeDateViewController *changDateVC;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIToolbar *tool;

- (IBAction)changeDate:(id)sender;

- (IBAction)takePhoto:(UIBarButtonItem *)sender;
- (IBAction)clearImage:(id)sender;

@end

@implementation NZDetailViewController

#pragma mark - override super method

- (void)viewDidLayoutSubviews
{
    for (UIView *view in self.view.subviews) {
        if ([view hasAmbiguousLayout]) {
            NSLog(@"ambiguous:%@",view);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
//    po [[UIWindow keyWindow] _autolayoutTrace] 检查有歧义的布局视图
    self.nameTextField.text = self.item.name;
    self.priceTextField.text = self.item.price;
    self.serialTextField.text = self.item.serial;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateStyle = kCFDateFormatterShortStyle;
    format.timeStyle = kCFDateFormatterLongStyle;
    self.date.text =
    [format stringFromDate:self.changDateVC.pickDate == nil ? self.item.createDate : self.changDateVC.pickDate];
    self.image.image = [[NZImageStore shareManager] imageForKey:self.item.itemKey];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.item.name = self.nameTextField.text;
    self.item.price = self.priceTextField.text;
    self.item.serial = self.serialTextField.text;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    for (UIView *view in self.view.subviews) {
        if ([view hasAmbiguousLayout]) {
            [view exerciseAmbiguityInLayout];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method

- (void)setItem:(NZItem *)item
{
    if (!_item) {
        _item = item;
        self.navigationItem.title = item.name;
    }
    
}

- (IBAction)changeDate:(id)sender
{
    self.changDateVC = [[NZChangeDateViewController alloc]init];
    self.changDateVC.pickDate = self.item.createDate;
//    
//    __weak __typeof(self) weakSelf = self;
//    self.changDateVC.pickDateBlk = ^(NSDate *date) {
//        weakSelf.item.createDate = date;
//    };
    
    [self.navigationController pushViewController:self.changDateVC animated:YES];
}


- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    UIImagePickerController *pickPhoto = [[UIImagePickerController alloc]init];
    UIView *overlay = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    overlay.center = CGPointMake(kWidth / 2, kHeight / 2);
    overlay.backgroundColor = [UIColor redColor];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickPhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        pickPhoto.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pickPhoto.cameraOverlayView = overlay;
    pickPhoto.delegate = self;
    pickPhoto.allowsEditing = YES;
//    pickPhoto.showsCameraControls = NO;
    [self presentViewController:pickPhoto animated:YES completion:nil];
}

- (IBAction)clearImage:(id)sender {
    [[NZImageStore shareManager] deleteImageForKey:self.item.itemKey];
    self.image.image = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    UIImage *image;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    self.image.image = image;
    [[NZImageStore shareManager] setImage:image forKey:self.item.itemKey];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
