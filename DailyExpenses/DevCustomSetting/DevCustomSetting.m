//
//  DevCustomSetting.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "DevCustomSetting.h"
#import <math.h>
#import "FakeModels.h"

@implementation DevCustomSetting

@synthesize firstView, howMuchAppCreateOnInit, removeFakeItensOnInit, isTester, currentWebView, htmlBasePath;

SynthensizeSingleTon(DevCustomSetting);

-(id)init{
    self = [super init];
    
    if (self) {
        removeFakeItensOnInit = YES;
        firstView = MainScreen;
        howMuchAppCreateOnInit = 25;
        [self createVariatyItensModel];
        //[self createFakeItensModel];
        isTester = YES;
        htmlBasePath = @"desire/";
        //htmlBasePath = @"http://localhost:8080/";
    }
    
    return self;
}

-(void)createVariatyItensModel{
    if (removeFakeItensOnInit) {
        NSManagedObjectContext *ctx = [[CoreDataService sharedInstance] context];
        NSArray *itens = [[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel];
        for (ItemModel *item in itens) {
            [ctx deleteObject:item];
        }
    }
    
    [FakeModels createVariatyOfItens];
}

-(void)createFakeItensModel{
    if (removeFakeItensOnInit) {
        NSManagedObjectContext *ctx = [[CoreDataService sharedInstance] context];
        NSArray *itens = [[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel];
        for (ItemModel *item in itens) {
            [ctx deleteObject:item];
        }
    }
    
    for (int i = 0; i < howMuchAppCreateOnInit; i++) {
        ItemModel *itemModel = (ItemModel*)[[CoreDataService sharedInstance] createManagedObjectWithName:EntityItemModel];
        
        NSDate *dateCreated = [[DateUtility sharedInstance] getCurrentDateN];
        itemModel.identifier = [NSString encodeToBase64:[NSString stringWithFormat:@"%@%d",dateCreated,i]];
        itemModel.dateCreated = dateCreated;
        itemModel.label = [NSString stringWithFormat:@"Fake - %@|%d",dateCreated,i];
        itemModel.value = [NSString stringWithFormat:@"%i", i];
        itemModel.dateSpent = dateCreated;
        
        BOOL value = fmod(i, 2) == 0 ? YES : NO;
        
        itemModel.isMoneyIn = [NSNumber numberWithBool:!value];
        itemModel.isMoneyOut = [NSNumber numberWithBool:value];
        
        itemModel.isCreditCard = [NSNumber numberWithBool:NO];
        itemModel.isMoney = [NSNumber numberWithBool:NO];
        itemModel.isDebitCard = [NSNumber numberWithBool:itemModel.isMoneyOut ? YES : NO];
        
        itemModel.category = [[CategoryManager sharedInstance] getDefaultCategory];
        
        NSLog(@"");
    }
}

-(void)executeJSCommand:(NSString*)command{
    [currentWebView stringByEvaluatingJavaScriptFromString:command];
}

@end
