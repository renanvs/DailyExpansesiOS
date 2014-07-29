//
//  DevCustomSetting.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "DevCustomSetting.h"
#import <math.h>

@implementation DevCustomSetting

@synthesize isNative, firstView, howMuchAppCreateOnInit, removeFakeItensOnInit;

SynthensizeSingleTon(DevCustomSetting);

-(id)init{
    self = [super init];
    
    if (self) {
        isNative = NO;
        removeFakeItensOnInit = YES;
        firstView = HistoryScreen;
        howMuchAppCreateOnInit = 25;
        [self createFakeItensModel];
    }
    
    return self;
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
        
        NSString *dateCreated = [[DateUtility sharedInstance] getCurrentDateWithHours];
        itemModel.identifier = [NSString encodeToBase64:[NSString stringWithFormat:@"%@%d",dateCreated,i]];
        itemModel.dateCreated = dateCreated;
        itemModel.label = [NSString stringWithFormat:@"Fake - %@|%d",dateCreated,i];
        itemModel.value = [NSString stringWithFormat:@"%i", i];
        itemModel.dateSpent = [[DateUtility sharedInstance] getCurrentDateWithFormat:@"yyyy-dd-MM"];
        
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

@end
