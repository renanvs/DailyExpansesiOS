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


@end
