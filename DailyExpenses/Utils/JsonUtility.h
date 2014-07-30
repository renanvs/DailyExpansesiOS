//
//  JsonUtility.h
//  DailyExpenses
//
//  Created by renan veloso silva on 19/06/14.
//
//

#import <Foundation/Foundation.h>

@interface JsonUtility : NSObject

+(NSArray*)itemListToJsonArrayList:(NSArray*)listItens;

+(NSArray*)categoryListToJsonArrayList:(NSArray*)listItens;

+(NSDictionary*)itemModelToItemDic:(ItemModel*)itemModel;

+(NSDictionary*)jsonStringToDictionary:(NSString*)jsonString;

@end
