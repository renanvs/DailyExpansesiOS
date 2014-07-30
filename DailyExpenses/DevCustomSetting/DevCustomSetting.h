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
    bool isNative;
    bool removeFakeItensOnInit;
    int howMuchAppCreateOnInit;
    FirstView firstView;

}

+(id)sharedInstance;

@property (nonatomic, assign) bool isTester;
@property (nonatomic, assign) bool isNative;
@property (nonatomic, assign) bool removeFakeItensOnInit;
@property (nonatomic, assign) FirstView firstView;
@property (nonatomic, assign) int howMuchAppCreateOnInit;

@end
