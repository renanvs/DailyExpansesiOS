//
//  FilterViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 05/06/14.
//
//

#import "FilterViewController.h"
#import "CategoryListCell.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

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
    
    categoryIdList = [[NSMutableArray alloc] init];
    [categoryIdList addObject:@"all"];
    //[categoryDictionary setObject:@"Todos" forKey:@"all"];
    
    NSArray* categoryModelList = [[CategoryManager sharedInstance] getAllCategories];
    
    for (CategoryModel *cat in categoryModelList) {
        [categoryIdList addObject:cat.identifier];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self addCheckbox];
}

-(void)addCheckbox{
    
    CGRect spendRect = CGRectMake(85, 0, 240, 30);
    CGRect creditRect = CGRectMake(0, 0, 240, 30);
    
    CGRect moneyRect = CGRectMake(0, 40, 60, 30);
    CGRect debitCardRect = CGRectMake(60, 40, 60, 30);
    CGRect creditCardRect = CGRectMake(120, 40, 60, 30);
    
    spent = [[SSCheckBoxView alloc] initWithFrame:spendRect style:kSSCheckBoxViewStyleGlossy checked:YES];
    rendimento = [[SSCheckBoxView alloc] initWithFrame:creditRect style:kSSCheckBoxViewStyleGlossy checked:NO];
    [spent setText:@"Despesa"];
    [rendimento setText:@"Rendimento"];
    [spent setStateChangedTarget:self selector:@selector(checkBoxViewChangedState:)];
    [rendimento setStateChangedTarget:self selector:@selector(checkBoxViewChangedState:)];
    [paymantView addSubview:spent];
    [paymantView addSubview:rendimento];
    
    spent.label.font = [UIFont fontWithName:spent.label.font.fontName size:9];
    rendimento.label.font = [UIFont fontWithName:rendimento.label.font.fontName size:9];
    
    money = [[SSCheckBoxView alloc] initWithFrame:moneyRect style:kSSCheckBoxViewStyleGlossy checked:NO];
    debit = [[SSCheckBoxView alloc] initWithFrame:debitCardRect style:kSSCheckBoxViewStyleGlossy checked:NO];
    creditCard = [[SSCheckBoxView alloc] initWithFrame:creditCardRect style:kSSCheckBoxViewStyleGlossy checked:NO];
    creditCard.label.font = [UIFont fontWithName:creditCard.label.font.fontName size:8.5];
    debit.label.font = [UIFont fontWithName:debit.label.font.fontName size:8.5];
    money.label.font = [UIFont fontWithName:money.label.font.fontName size:8.5];
    creditCard.label.text = @"Crédito";
    debit.label.text = @"Débito";
    money.label.text = @"Dinheiro";
    [creditCard setStateChangedTarget:self selector:@selector(checkBoxSpentChangedState:)];
    [debit setStateChangedTarget:self selector:@selector(checkBoxSpentChangedState:)];
    [money setStateChangedTarget:self selector:@selector(checkBoxSpentChangedState:)];
    
    [paymantView addSubview:money];
    [paymantView addSubview:debit];
    [paymantView addSubview:creditCard];
}

- (void) checkBoxViewChangedState:(SSCheckBoxView *)checkBox
{
    if (checkBox == spent) {
        rendimento.checked = !checkBox.checked;
    }else if(checkBox == rendimento) {
        spent.checked = !checkBox.checked;
    }
}

-(void)checkBoxSpentChangedState:(SSCheckBoxView *)checkBox
{
    creditCard.checked = NO;
    debit.checked = NO;
    money.checked = NO;
    
    if (!rendimento.checked) {
        checkBox.checked = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [initialDate release];
    [finalDate release];
    [categoryTableView release];
    [paymantView release];
    [super dealloc];
}
- (IBAction)initialDateHandler:(id)sender {
}

- (IBAction)FinalDateHandler:(id)sender {
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return categoryIdList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CategoryListCell";
    CategoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    NSString *desireKey = [categoryIdList objectAtIndex:row];
    
    NSString *label = @"";
    UIImage *image = nil;
    
    if ([desireKey isEqualToString:@"all"]) {
        label = @"Todos";
    }else{
        CategoryModel *categoryModel = [[CategoryManager sharedInstance] getCategoryById:desireKey];
        if (categoryModel) {
            image = [UIImage imageNamed:categoryModel.imageName];
            label = categoryModel.name;
        }
    }
    
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[CategoryListCell class]]) {
                cell = (CategoryListCell*)currentObject;
                cell.icon.image = image;
                cell.label.text = label;
                
                break;
            }
        }
    }
    
    return cell;
}

@end
