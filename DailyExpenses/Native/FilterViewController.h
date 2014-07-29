//
//  FilterViewController.h
//  DailyExpenses
//
//  Created by renan veloso silva on 05/06/14.
//
//

#import <UIKit/UIKit.h>
#import "SSCheckBoxView.h"

@interface FilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UIButton *initialDate;
    IBOutlet UIButton *finalDate;
    
    IBOutlet UITableView *categoryTableView;
    IBOutlet UIView *paymantView;
    
    NSMutableArray *categoryIdList;
    
    SSCheckBoxView* spent;
    SSCheckBoxView* rendimento;
    
    SSCheckBoxView* money;
    SSCheckBoxView* debit;
    SSCheckBoxView* creditCard;
    
}
- (IBAction)initialDateHandler:(id)sender;
- (IBAction)FinalDateHandler:(id)sender;

@end
