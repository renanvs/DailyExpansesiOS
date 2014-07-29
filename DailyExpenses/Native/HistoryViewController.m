//
//  HistoryViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "HistoryViewController.h"
#import "ItemCell.h"
#import "FilterViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)filterHandler:(UIButton *)sender {
    FilterViewController *filterVc = [[FilterViewController alloc] init];
    [self presentViewController:filterVc animated:YES completion:nil];
}

- (IBAction)orderHandler:(UIButton *)sender {
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *list = [[ItemManager sharedInstance] getAllItens];
    return list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil] lastObject];
    }
    
    NSArray *list = [[ItemManager sharedInstance] getAllItens];
    ItemModel *itemModel = [list objectAtIndex:indexPath.row];
    [cell setItemModel:itemModel];
    
    return cell;
}

- (void)dealloc {
    [_historyTableView release];
    [super dealloc];
}
@end
