//
//  AddItemViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "AddItemViewController.h"
#import "CategoryListCell.h"

@implementation AddItemViewController

#pragma mark - init, view...

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackground];
    
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
    [self.typeView addSubview:spent];
    [self.typeView addSubview:rendimento];
    
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
    
    [self.typeView addSubview:money];
    [self.typeView addSubview:debit];
    [self.typeView addSubview:creditCard];
    
    //TODO: criar método para cada tipo de ajuste
    if ([state isEqualToString:@"update"]){
        [self populateToForm];
        [self.add setTitle:@"Atualizar"];
    }else{
        self.add.title = @"Cadastrar";
        self.dateStr.text = [[DateUtility sharedInstance] getCurrentDate];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!currentCategory) {
        currentCategory = [[CategoryManager sharedInstance] getDefaultCategory];
    }
    
    self.typeLabel.text = currentCategory.name;
    UIImage *iconImg = [UIImage imageNamed:currentCategory.imageName];
    [self.typeBt setImage:iconImg forState:UIControlStateNormal];
}

- (void) checkBoxViewChangedState:(SSCheckBoxView *)checkBox
{
    if (checkBox == spent) {
        rendimento.checked = !checkBox.checked;
    }else if(checkBox == rendimento) {
        spent.checked = !checkBox.checked;
    }
    
    if (rendimento.checked) {
        [self.value setTextColor:[UIColor greenColor]];
        [self checkBoxSpentChangedState:nil];
    }else if (spent.checked){
        [self.value setTextColor:[UIColor redColor]];
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

- (void)viewDidUnload {
    [self setLabel:nil];
    [self setParcel:nil];
    [self setValue:nil];
    [self setDateStr:nil];
    [self setNote:nil];
    [self setTypeLabel:nil];
    [self setTypeView:nil];
    [super viewDidUnload];
}

-(id)init{
    self =[super init];
    
    if (self) {
		state = @"new";
        [self initialize];
    }
    
    return self;
}

-(id)initWithId:(NSString*)itemId{
    self =[super init];
    
	if (self) {
		state = @"update";
        item = [[ItemManager sharedInstance] getItemById:itemId];
        [self initialize];
    }
    
    return self;
}

-(void)initialize{
	categoryList = [[[CategoryManager sharedInstance] getAllCategories] retain];
	parcelDatasource = [NativeUtility getParcelList];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [_typeView release];
    [super dealloc];
}

#pragma mark - IBAction's

-(IBAction)cadastrar:(id)sender{
    [self addItem];
}

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectType:(id)sender {
    [self closeKeyboard];
    [self createCategoryTableView];
}

- (IBAction)showDatePicker:(id)sender {
    [self closeKeyboard];
    [self createDatePicker];
}

- (IBAction)showParcelPicker:(id)sender {
    [self closeKeyboard];
    [self createParcelPicker];
}

#pragma mark - textFieldDelegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.dateStr || textField == self.parcel) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableViewDelegate Methods

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CategoryListCell";
    CategoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    CategoryModel *categoryModel = [categoryList objectAtIndex:row];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[CategoryListCell class]]) {
                cell = (CategoryListCell*)currentObject;
                cell.icon.image = [UIImage imageNamed:categoryModel.imageName];
                cell.label.text = categoryModel.name;
                break;
            }
        }
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return categoryList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentCategory = [categoryList objectAtIndex:indexPath.row];
    self.typeLabel.text = currentCategory.name;
    UIImage *iconImg = [UIImage imageNamed:currentCategory.imageName];
    [self.typeBt setImage:iconImg forState:UIControlStateNormal];
    bgView.hidden = YES;
}

#pragma mark - create dataPicker and pickerView

//TODO: Criar Class de criação de views
-(void)createDatePicker{
	[[NativeUtility sharedInstance] removeElementsFromView:bgView];
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (480-216), 320, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt-BR"];
    datePicker.calendar = [datePicker.locale objectForKey:NSLocaleCalendar];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    [outputFormatter setLocale:datePicker.locale];
    self.dateStr.text = [outputFormatter stringFromDate:[datePicker date]];
    
    dataPickerDoneBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataPickerDoneBt.frame = CGRectMake(0, 0, 70, 30);
	[[NativeUtility sharedInstance] setItem:dataPickerDoneBt inView:datePicker side:@"right" UpDown:@"up" padLeft:0 padTop:0 padRight:0 padBottom:0];
    [dataPickerDoneBt setTitle:@"choose" forState:UIControlStateNormal];
    [dataPickerDoneBt addTarget:self action:@selector(dataPickerDone:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:dataPickerDoneBt];
    [bgView addSubview:datePicker];
    
    bgView.hidden = NO;
}

-(void)createParcelPicker{
	[[NativeUtility sharedInstance] removeElementsFromView:bgView];
    parcelPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, (480-216), 320, 216)];
    parcelPicker.delegate = self;
    parcelPicker.dataSource = self;
    parcelPicker.showsSelectionIndicator = YES;
    
    self.parcel.text = @"";
    
    parcelPickerDoneBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    parcelPickerDoneBt.frame = CGRectMake(0, 0, 70, 30);
	[[NativeUtility sharedInstance] setItem:parcelPickerDoneBt inView:parcelPicker side:@"right" UpDown:@"up" padLeft:0 padTop:0 padRight:0 padBottom:0];
    [parcelPickerDoneBt setTitle:@"Done" forState:UIControlStateNormal];
    [parcelPickerDoneBt addTarget:self action:@selector(parcelPickerDone:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:parcelPickerDoneBt];
    [bgView addSubview:parcelPicker];
    
    bgView.hidden = NO;
    
}

-(void)createCategoryTableView{
	[[NativeUtility sharedInstance] removeElementsFromView:bgView];
	categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, 360) style:UITableViewStylePlain];
	categoryTableView.delegate = self;
	categoryTableView.dataSource = self;
	[[NativeUtility sharedInstance] setItem:categoryTableView inCenterView:bgView padLeft:0 padTop:45 padRight:0 padBottom:0];
	
	categoryTableDoneBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	categoryTableDoneBt.frame = CGRectMake(0, 0, 70, 30);
	[categoryTableDoneBt setTitle:@"Close" forState:UIControlStateNormal];
	[categoryTableDoneBt addTarget:self action:@selector(categoryTableDone:) forControlEvents:UIControlEventTouchUpInside];
	[[NativeUtility sharedInstance]setItem:categoryTableDoneBt inView:categoryTableView side:@"right" UpDown:@"up" padLeft:0 padTop:0 padRight:0 padBottom:0];
	
	[bgView addSubview:categoryTableView];
	[bgView addSubview:categoryTableDoneBt];
	
	bgView.hidden = NO;
}

#pragma mark - keyboard methods
-(void)keyboardDidShow:(NSNotification*)notification{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameValue = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameRect = [keyboardFrameValue CGRectValue];
    
    closeKeyboardBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeKeyboardBt.frame = CGRectMake((keyboardFrameRect.size.width-70), (keyboardFrameRect.origin.y-30), 70, 30);
    [closeKeyboardBt setTitle:@"Fechar" forState:UIControlStateNormal];
    [closeKeyboardBt addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeKeyboardBt];
}

-(void)keyboardWillHide:(NSNotification*)notification{
    [closeKeyboardBt removeFromSuperview];
}

-(void)closeKeyboard{
    for (UITextField *tf in [self.tpScrollView subviews]) {
        [tf resignFirstResponder];
        
    }
}

#pragma mark - other methods
//r// analisar a necessidade desse método
-(void)setBackground{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    bgView.hidden = YES;
    [self.view addSubview:bgView];
    
}

-(void)populateToForm{
	UIImage *categoryImage;
    self.label.text = item.label;
	self.typeLabel.text = [NSString stringWithFormat:@"%@", item.category.name];
	self.parcel.text = [NSString stringWithFormat:@"%@x",item.parcel];
	self.value.text = item.value;
	self.dateStr.text = item.dateSpent;
	self.note.text = item.notes;
    categoryImage = [UIImage imageNamed:item.category.imageName];
	[self.typeBt setImage:categoryImage forState:UIControlStateNormal];
    
    rendimento.checked = [item.isMoneyIn boolValue];
    
    creditCard.checked = [item.isCreditCard boolValue];
    debit.checked = [item.isDebitCard boolValue];
    money.checked = [item.isMoneyOut boolValue];
    
    if (creditCard.checked || debit.checked || money.checked) {
        spent.checked = YES;
    }else{
        spent.checked = NO;
    }
    
    if (rendimento.checked) {
        [self.value setTextColor:[UIColor greenColor]];
    }else if (spent.checked){
        [self.value setTextColor:[UIColor redColor]];
    }
	
}

-(void)addItem{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:self.label.text forKey:JsonItemLabel];
    [dic setObject:self.typeLabel.text forKey:JsonCategoryName];
    [dic setObject:[self.parcel.text stringByReplacingOccurrencesOfString:@"x" withString:@""] forKey:JsonItemParcel];
    [dic setObject:self.value.text forKey:JsonItemValue];
    [dic setObject:self.dateStr.text forKey:JsonItemSpent];
    [dic setObject:self.note.text forKey:JsonItemNotes];
    
    [dic setObject:[NSNumber numberWithBool:spent.checked] forKey:JsonItemSpent];
    [dic setObject:[NSNumber numberWithBool:creditCard.checked] forKey:JsonItemCreditCard];
    [dic setObject:[NSNumber numberWithBool:debit.checked] forKey:JsonItemDebit];
    [dic setObject:[NSNumber numberWithBool:money.checked] forKey:JsonItemMoney];
    [dic setObject:[NSNumber numberWithBool:rendimento.checked] forKey:JsonItemRendimento];
    
    NSMutableDictionary *catDic = [[NSMutableDictionary alloc] init];
    if (currentCategory) {
        [catDic setObject:currentCategory.identifier forKey:JsonCategoryIdentifier];
        [catDic setObject:currentCategory.name forKey:JsonCategoryName];
    }else{
        [catDic setObject:@"default" forKey:JsonCategoryIdentifier];
        [catDic setObject:@"default" forKey:JsonCategoryName];
    }
    
    [dic setObject:catDic forKey:JsonItemCategory];

    NSData *json = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //TODO: o controler tem que identificar se o item é novo ou atualizado
    if ([state isEqualToString:@"update"]) {
        [[ItemManager sharedInstance] UpdateItemWithJson:json];
    }else{
        [[ItemManager sharedInstance] CreateItemWithJson:json];
    }
    
    [self back:nil];
}

#pragma mark - Pickers and Table Done Button

-(void)dataPickerDone:(id)event{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    [outputFormatter setLocale:datePicker.locale];
    self.dateStr.text = [outputFormatter stringFromDate:[datePicker date]];
    bgView.hidden = YES;
}

-(void)parcelPickerDone:(id)event{
	NSInteger row = [parcelPicker selectedRowInComponent:0];
	self.parcel.text = [parcelDatasource objectAtIndex:row];
    bgView.hidden = YES;;
}

-(void)categoryTableDone:(id)event{
	CGRect categoryRect = categoryTableView.frame;
	[UIView animateWithDuration:.5 animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[categoryTableView setFrame:CGRectMake(categoryRect.origin.x, categoryRect.origin.y + categoryRect.size.height,
											   categoryRect.size.width,categoryRect.size.height)];
	}completion:^(BOOL finished){
		bgView.hidden = YES;
	}];
	
}

#pragma mark - pickerViewDelegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return parcelDatasource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [parcelDatasource objectAtIndex:row];
}

@end
