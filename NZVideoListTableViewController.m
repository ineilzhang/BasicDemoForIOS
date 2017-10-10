//
//  NZVideoListTableViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/10/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZVideoListTableViewController.h"
#import "NZWebViewController.h"

@interface NZVideoListTableViewController ()

@property (nonatomic,strong) NSURLSession *session;

@property (nonatomic,strong) NSArray *courses;

@end

@implementation NZVideoListTableViewController

#pragma mark - override super method

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Video List";
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
        [self fetchTestJson];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method

- (void)fetchTestJson
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.108/test.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task =
    [self.session dataTaskWithRequest:request
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSDictionary *dic =
                        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                              error:nil];
                        self.courses = dic[@"course"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
    } ];
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *couseName = [self.courses[indexPath.row] valueForKey:@"title"];
    cell.textLabel.text = couseName;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = [self.courses objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NZWebViewController *webVC = [NZWebViewController new];
    webVC.url = url;
    [self presentViewController:webVC animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
