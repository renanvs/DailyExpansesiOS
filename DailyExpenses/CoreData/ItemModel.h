//
//  ItemModel.h
//  DailyExpenses
//
//  Created by renan veloso silva on 06/08/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardModel, CategoryModel;

@interface ItemModel : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSDate * dateSpent;
@property (nonatomic, retain) NSDate * dateUpdated;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * isCreditCard;
@property (nonatomic, retain) NSNumber * isDebitCard;
@property (nonatomic, retain) NSNumber * isMoney;
@property (nonatomic, retain) NSNumber * isMoneyIn;
@property (nonatomic, retain) NSNumber * isMoneyOut;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * parcel;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) CardModel *card;
@property (nonatomic, retain) CategoryModel *category;

@end
