//
//  JsonUtility.m
//  DailyExpenses
//
//  Created by renan veloso silva on 19/06/14.
//
//

#import "JsonUtility.h"

@implementation JsonUtility

+(NSArray*)itemListToJsonArrayList:(NSArray*)listItens{
    NSMutableArray *jsonList = [[NSMutableArray alloc] init];
    
    for (ItemModel *itemModel in listItens) {
        
        [jsonList addObject:[self itemModelToItemDic:itemModel]];
    }
    
    return jsonList;
}

+(NSDictionary*)itemModelToItemDic:(ItemModel*)itemModel{
    NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] init];
    
    [itemDic setString:itemModel.identifier forKey:JsonItemIdentifier];
    [itemDic setString:itemModel.label forKey:JsonItemLabel];
    [itemDic setObject:itemModel.isMoneyOut forKey:JsonItemSpent];
    [itemDic setObject:itemModel.value forKey:JsonItemValue];
    [itemDic setString:itemModel.dateCreated forKey:JsonItemDateCreated];
    [itemDic setString:[self formatDateToHTML:itemModel.dateSpent] forKey:JsonItemDateSpent];
    [itemDic setString:itemModel.dateUpdated forKey:JsonItemDateUpdated];
    [itemDic setObject:itemModel.isCreditCard forKey:JsonItemCreditCard];
    [itemDic setObject:itemModel.isDebitCard forKey:JsonItemDebit];
    [itemDic setObject:itemModel.isMoney forKey:JsonItemMoney];
    [itemDic setString:itemModel.notes forKey:JsonItemNotes];
    [itemDic setString:itemModel.parcel forKey:JsonItemParcel];
//    
//    NSMutableDictionary *catDic = [[NSMutableDictionary alloc] init];
//    [catDic setObject:[self catModelTocatDic:itemModel.category] forKey:JsonItemCategory];
    [itemDic setObject:[self catModelTocatDic:itemModel.category] forKey:JsonItemCategory];
    
    return itemDic;
}

+(NSString*)formatDateToHTML:(NSString*)dateStr{
    NSMutableString *dateFormatted = [[NSMutableString alloc] initWithString:@""];
    NSArray *dateArray = [dateStr componentsSeparatedByString:@"-"];
    [dateFormatted appendString:[dateArray objectAtIndex:0]];
    [dateFormatted appendString:@"-"];
    [dateFormatted appendString:[dateArray objectAtIndex:2]];
    [dateFormatted appendString:@"-"];
    [dateFormatted appendString:[dateArray objectAtIndex:1]];
    return dateFormatted;
}

+(NSArray*)categoryListToJsonArrayList:(NSArray*)listcategories{
    NSMutableArray *jsonList = [[NSMutableArray alloc] init];
    
    for (CategoryModel *catModel in listcategories) {
        
        [jsonList addObject:[self catModelTocatDic:catModel]];
    }
    
    return jsonList;
}

+(NSDictionary*)catModelTocatDic:(CategoryModel*)catModel{
    NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] init];
    
    [itemDic setString:catModel.identifier forKey:JsonCategoryIdentifier];
    [itemDic setString:catModel.name forKey:JsonCategoryName];
    [itemDic setString:catModel.imageName forKey:JsonCategoryImagePath];
    
    return itemDic;
}

@end
