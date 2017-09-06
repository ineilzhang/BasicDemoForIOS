//
//  ViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "ViewController.h"
#import "NZItemStore.h"
#import "NZDetailViewController.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UIView *headView;

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) NZItemStore *itemsStore;

- (IBAction)edit:(id)sender;

- (IBAction)add:(id)sender;

@end

@implementation ViewController

- (instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigationItem.title = @"Home";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                     target:self
                                                     action:@selector(add:)];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NZItemStore *)itemsStore{
    if (!_itemsStore) {
        _itemsStore = [NZItemStore shareManage];
    }
    return _itemsStore;
}


- (UIView *)headView{
    if (!_headView) {
        NSBundle *main = [NSBundle mainBundle];
        [main loadNibNamed:@"head" owner:self options:nil];
    }
    return _headView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
//    self.tableView.tableHeaderView = self.headView;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[NZItemStore shareManage] allItems] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NZItemStore *items = [NZItemStore shareManage];
    if (indexPath.row == ([tableView numberOfRowsInSection:0] - 1)) {
        cell.textLabel.text = @"No more items!";
    }else{
        cell.textLabel.text = [[[items allItems] objectAtIndex:indexPath.row] description];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath row:%ld",indexPath.row);
    NZDetailViewController *detailVC = [[NZDetailViewController alloc]init];
    NZItem *selectItem = [[self.itemsStore allItems] objectAtIndex:indexPath.row];
    detailVC.item = selectItem;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == ([tableView numberOfRowsInSection:0] - 1)) {
        return NO;
    }
    return YES;
}

- (void)edit:(id)sender{
    if (self.isEdit) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
        self.isEdit = NO;
    }else{
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
        self.isEdit = YES;
    }
}

- (void)add:(id)sender{
    NZItem *item = [[NZItemStore shareManage] createItem];
    NSInteger row = [[[NZItemStore shareManage] allItems] indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row == ([tableView numberOfRowsInSection:0] - 1)) {
            return;
        }
        NZItem *item = [[[NZItemStore shareManage] allItems] objectAtIndex:indexPath.row];
        [[NZItemStore shareManage] deleteItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (destinationIndexPath.row == ([tableView numberOfRowsInSection:0] - 1)) {
        [tableView moveRowAtIndexPath:destinationIndexPath toIndexPath:sourceIndexPath];
        [tableView reloadData];
        return;
    }
    [self.itemsStore moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"remove";
}
@end
