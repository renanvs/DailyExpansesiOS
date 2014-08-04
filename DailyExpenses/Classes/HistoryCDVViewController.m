//
//  HistoryCDVViewController.m
//  DailyExpenses
//
//  Created by renan veloso silva on 01/08/14.
//
//

#import "HistoryCDVViewController.h"

@implementation HistoryCDVViewController

- (void)viewDidLoad
{
    self.startPage = @"desire/index_history.html";
    [super viewDidLoad];
    [[DevCustomSetting sharedInstance] setCurrentWebView:self.webView];
    // Do any additional setup after loading the view.
}

@end