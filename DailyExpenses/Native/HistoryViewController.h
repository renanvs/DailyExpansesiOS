//
//  HistoryViewController.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)filterHandler:(UIButton *)sender;
- (IBAction)orderHandler:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITableView *historyTableView;

@end
