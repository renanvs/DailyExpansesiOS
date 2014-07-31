//
//  ItemManager.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <Foundation/Foundation.h>

#define EntityItemModel  @"ItemModel"

@interface ItemManager : NSObject{
    NSMutableArray *allItens;
    NSString *itemIdentifier;
}

+(id)sharedInstance;

-(ItemModel*)getItemById:(NSString*)identifier;

-(ItemModel*)UpdateItemWithJson:(id)json;

-(ItemModel*)CreateItemWithJson:(id)json;

-(ItemModel*)CreateOrUpdateItemWithDictionary:(NSDictionary*)dic;

-(NSArray*)getAllItens;

@property(nonatomic, assign) NSString *itemIdentifier;

-(ItemModel*)getLastItem;

-(NSArray*)getItensWithFilterDictionary:(NSDictionary*)dic;

@end
