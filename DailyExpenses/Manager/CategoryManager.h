//
//  CategoryManager.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <Foundation/Foundation.h>

#define EntityCategoryModel  @"CategoryModel"

@interface CategoryManager : NSObject{
    NSDictionary *defaultCategoryDictionary;
}

@property (nonatomic, assign) NSDictionary *defaultCategoryDictionary;

+(id)sharedInstance;

-(NSArray*)getAllCategories;

-(CategoryModel*)getCategoryById:(NSString*)identifier;

-(CategoryModel*)getDefaultCategory;

@end
