//
//  FormCDVViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 27/06/14.
//
//

#import "FormCDVViewController.h"

@implementation FormCDVViewController

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
//    self.startPage = @"desire/index_form.html";
    self.startPage = [AppUtility baseUrlWithAppendPath:@"/index_form.html"];
    [super viewDidLoad];
    [[DevCustomSetting sharedInstance] setCurrentWebView:self.webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
