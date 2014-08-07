//
//  CardModel.h
//  DailyExpenses
//
//  Created by renan veloso silva on 06/08/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemModel;

@interface CardModel : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *itens;
@end

@interface CardModel (CoreDataGeneratedAccessors)

- (void)addItensObject:(ItemModel *)value;
- (void)removeItensObject:(ItemModel *)value;
- (void)addItens:(NSSet *)values;
- (void)removeItens:(NSSet *)values;

@end
