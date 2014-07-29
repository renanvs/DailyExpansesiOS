//
//  AddItemViewController.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <UIKit/UIKit.h>
#import "SSCheckBoxView.h"
#import "NativeUtility.h"

@interface AddItemViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    
    ItemModel *item;
    CategoryModel *currentCategory;
    
    UIDatePicker *datePicker;
    UIButton *dataPickerDoneBt;
	
	UIPickerView *parcelPicker;
    UIButton *parcelPickerDoneBt;
    NSArray *parcelDatasource;
	
	NSArray * categoryList;
	UIButton *categoryTableDoneBt;
	UITableView *categoryTableView;
	
	UIView *bgView;
    
    UIButton *closeKeyboardBt;
	
	NSString *state;
    
    SSCheckBoxView* spent;
    SSCheckBoxView* rendimento;
    
    SSCheckBoxView* money;
    SSCheckBoxView* debit;
    SSCheckBoxView* creditCard;
}

@property (assign, nonatomic) IBOutlet UITextField *label;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (assign, nonatomic) IBOutlet UITextField *parcel;
@property (assign, nonatomic) IBOutlet UITextField *value;
@property (assign, nonatomic) IBOutlet UITextField *dateStr;
@property (assign, nonatomic) IBOutlet UITextView *note;
@property (assign, nonatomic) IBOutlet UIButton *typeBt;
@property (assign, nonatomic) IBOutlet UIBarButtonItem *add;
@property (retain, nonatomic) IBOutlet UIView *typeView;
@property (assign, nonatomic) IBOutlet UIScrollView *tpScrollView;

-(IBAction)cadastrar:(id)sender;
-(IBAction)back:(id)sender;
- (IBAction)selectType:(id)sender;
- (IBAction)showDatePicker:(id)sender;
- (IBAction)showParcelPicker:(id)sender;

//-(id)initWithId:(NSString*)itemId;

@end
