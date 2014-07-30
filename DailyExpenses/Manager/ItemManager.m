//
//  ItemManager.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "ItemManager.h"

@implementation ItemManager
@synthesize itemIdentifier;

SynthensizeSingleTon(ItemManager)

-(ItemModel*)getItemById:(NSString*)identifier{
    NSString *query = [NSString stringWithFormat:@"identifier == '%@'", identifier];
    NSArray *list = [[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel AndQuery:query];
    if (list == nil || list.count == 0) {
        return nil;
    }
    
    return [list lastObject];
}

-(void)setItemIdentifier:(NSString *)_itemIdentifier{
    itemIdentifier = [[NSString alloc] initWithString:_itemIdentifier];
    
}

-(ItemModel*)getLastItem{
    if ([NSString isStringEmpty:itemIdentifier]) {
        return nil;
    }
    ItemModel *item = [self getItemById:itemIdentifier];
    [itemIdentifier release];
    itemIdentifier = nil;
    return item;
}

-(ItemModel *)CreateItemWithJson:(id)json{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
    
    ItemModel *model = (ItemModel*)[[CoreDataService sharedInstance] createManagedObjectWithName:EntityItemModel];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    
    model.label = [dic objectForKey:@"label"];
    model.parcel = [dic objectForKey:@"parcel"];
    model.value = [dic objectForKey:@"value"];
    model.dateSpent = [dic objectForKey:@"dateSpent"];
    model.notes = [dic objectForKey:@"notes"];
    model.isMoneyIn = [dic objectForKey:@"rendimento"];
    model.isMoneyOut = [dic objectForKey:@"spent"];
    model.isCreditCard = [dic objectForKey:@"creditCard"];
    model.isDebitCard = [dic objectForKey:@"debit"];
    model.isMoney = [dic objectForKey:@"money"];
    NSString *currentDateWithHour = [[DateUtility sharedInstance] getCurrentDateWithHours];
    model.dateCreated = currentDateWithHour;
    model.identifier = [NSString encodeToBase64:currentDateWithHour];
    model.category = [[CategoryManager sharedInstance] getCategoryById:[dic objectForKey:@"identifier"]];
    
    [[CoreDataService sharedInstance] saveContext];
    
    return model;
}

-(ItemModel *)UpdateItemWithJson:(id)json{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *query = [NSString stringWithFormat:@"identifier == %@", [dic objectForKey:@"identifier"]];
    
    NSArray *models = [[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel AndQuery:query];
    ItemModel *model = (ItemModel*)[models lastObject];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    model.label = [dic objectForKey:@"label"];
    model.parcel = [dic objectForKey:@"parcel"];
    model.value = [dic objectForKey:@"value"];
    model.dateSpent = [dic objectForKey:@"dateSpent"];
    model.notes = [dic objectForKey:@"notes"];
    model.isMoneyIn = [formatter numberFromString:[dic objectForKey:@"rendimento"]];
    model.isMoneyOut = [formatter numberFromString:[dic objectForKey:@"spent"]];
    model.isCreditCard = [formatter numberFromString:[dic objectForKey:@"creditCard"]];
    model.isDebitCard = [formatter numberFromString:[dic objectForKey:@"debit"]];
    model.isMoney = [formatter numberFromString:[dic objectForKey:@"money"]];
    model.dateCreated = [[DateUtility sharedInstance] getCurrentDateWithHours];
    
    model.category = [[CategoryManager sharedInstance] getCategoryById:[dic objectForKey:@"identifier"]];
    
    return model;
}

-(NSArray*)getAllItens{
    if (allItens) {
        [allItens release];
        allItens = nil;
    }
    
    allItens = [[NSMutableArray alloc] initWithArray:[[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel]];
    return allItens;
}

-(NSArray*)getItensWithFilterDictionary:(NSDictionary*)dic{
    if (!dic) {
        NSLog(@"dicionario do filtro nulo");
        return nil;
    }
    
    NSString *query = [self createFilterQueryWithDictionary:dic];
    
//    NSString * dateCreated;
//    NSString * dateSpent;
//    NSString * dateUpdated;
//    NSNumber * isCreditCard;
//    NSNumber * isDebitCard;
//    NSNumber * isMoneyIn;
//    NSNumber * isMoneyOut;
//    NSString * label;
//    NSString * notes;
//    NSString * parcel;
//    NSString * value;
//    NSNumber * isMoney;
//    NSString * identifier;
//    CardModel *card;
//    CategoryModel *category;
    
    //dateType - (allDate || specificDate)
    //initDate - (2014-07-30)
    //endDate - (2014-07-30)
    //description - (sample description)
    //includeNotes -  true/false
    //moneyIn - true/false
    //money - true/false
    //debit - true/false
    //credit - true/false
    //CategoryType - selectedCategories/allCategories
    //initValue - 1
    //endValue - 2
    //categoriesSelected - (array)1, 2, 3
    
    NSArray *list = [[CoreDataService sharedInstance] getContentWithEntity:EntityItemModel AndQuery:query];
    
    return list;
}

-(NSString*)createFilterQueryWithDictionary:(NSDictionary*)dic{
    NSMutableString *query = [[NSMutableString alloc] initWithString:@""];
    
    
    NSString *dateType = [dic objectForKey:@"dateType"];
    if ([dateType isEqualToString:@"specificDate"]) {
        NSString *initDate = [dic objectForKey:@"initDate"];
        NSString *endDate = [dic objectForKey:@"endDate"];
        [query appendFormat:@"dateSpent >= %@ && ",initDate];
        [query appendFormat:@"dateSpent <= %@ && ",endDate];
    }
    
    NSString *description = [dic objectForKey:@"description"];
    if (![NSString isStringEmpty:description]) {
        [query appendFormat:@"label CONTAINS[cd] '%@' && ",description];
        
        BOOL includeNotes = [[dic objectForKey:@"includeNotes"] boolValue];
        if (includeNotes) {
            [query appendFormat:@"notes CONTAINS[cd] '%@' && ",description];
        }
    }
    
    BOOL moneyIn = [[dic objectForKey:@"moneyIn"] boolValue];
    [query appendFormat:@"(isMoneyIn == %@ || ",[NSNumber numberWithBool:moneyIn]];

    BOOL money = [[dic objectForKey:@"money"] boolValue];
    BOOL debit = [[dic objectForKey:@"debit"] boolValue];
    BOOL credit = [[dic objectForKey:@"credit"] boolValue];
    
    [query appendFormat:@"isMoney == %@ || ",[NSNumber numberWithBool:money]];
    [query appendFormat:@"isDebitCard == %@ || ",[NSNumber numberWithBool:debit]];
    [query appendFormat:@"isCreditCard == %@) && ",[NSNumber numberWithBool:credit]];
    
    
    NSString *categoryType = [dic objectForKey:@"CategoryType"];
    if ([categoryType isEqualToString:@"selectedCategories"]) {
        if ([dateType isEqualToString:@"specificDate"]) {
            NSArray *categoriesSelected = [dic objectForKey:@"categoriesSelected"];
            if (!categoriesSelected && categoriesSelected.count > 0) {
                for (NSNumber *num in categoriesSelected) {
                    [query appendFormat:@"category.identifier == %@ && ",num];
                }
            }
        }
    }
    
    NSString *initValue = [dic objectForKey:@"initValue"];
    NSString *endValue = [dic objectForKey:@"endValue"];
    
    if (![NSString isStringEmpty:initValue] && ![NSString isStringEmpty:endValue]) {
        [query appendFormat:@"value >= '%@' && ",initValue];
        [query appendFormat:@"value <= '%@' && ",endValue];
    }else if (![NSString isStringEmpty:initValue]){
        [query appendFormat:@"value == '%@' && ",initValue];
    }
    
    NSString *fQuery = [query substringToIndex:(query.length -4)];
    
    return fQuery;
}

@end
