//
//  ItemModel.h
//  DailyExpenses
//
//  Created by renan veloso silva on 01/06/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardModel, CategoryModel;

@interface ItemModel : NSManagedObject

@property (nonatomic, retain) NSString * dateCreated;
@property (nonatomic, retain) NSString * dateSpent;
@property (nonatomic, retain) NSString * dateUpdated;
@property (nonatomic, retain) NSNumber * isCreditCard;
@property (nonatomic, retain) NSNumber * isDebitCard;
@property (nonatomic, retain) NSNumber * isMoneyIn;
@property (nonatomic, retain) NSNumber * isMoneyOut;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * parcel;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSNumber * isMoney;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) CardModel *card;
@property (nonatomic, retain) CategoryModel *category;

@end
