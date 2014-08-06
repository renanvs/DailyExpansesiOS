//
//  DevCustomSetting.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    MainScreen,
    AddScreen,
    HistoryScreen
}FirstView;

@interface DevCustomSetting : NSObject{
    bool isTester;
    bool removeFakeItensOnInit;
    int howMuchAppCreateOnInit;
    FirstView firstView;
    UIWebView *currentWebView;
    NSString *htmlBasePath;
}

+(id)sharedInstance;

@property (nonatomic, assign) bool isTester;
@property (nonatomic, assign) NSString *htmlBasePath;
@property (nonatomic, assign) bool removeFakeItensOnInit;
@property (nonatomic, assign) FirstView firstView;
@property (nonatomic, assign) UIWebView *currentWebView;
@property (nonatomic, assign) int howMuchAppCreateOnInit;

-(void)executeJSCommand:(NSString*)command;

@end
