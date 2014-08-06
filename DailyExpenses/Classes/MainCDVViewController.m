//
//  MainCDVViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 01/08/14.
//
//

#import "MainCDVViewController.h"

@implementation MainCDVViewController

- (void)viewDidLoad
{
//    self.startPage = @"desire/index_main.html";
    self.startPage = [AppUtility baseUrlWithAppendPath:@"/index_main.html"];
    
    [super viewDidLoad];
    [[DevCustomSetting sharedInstance] setCurrentWebView:self.webView];
    // Do any additional setup after loading the view.
}

@end
