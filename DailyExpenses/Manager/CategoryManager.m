//
//  CategoryManager.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "CategoryManager.h"

@implementation CategoryManager

@synthesize defaultCategoryDictionary;

SynthensizeSingleTon(CategoryManager)

-(NSArray*)getAllCategories{
    
    return [[CoreDataService sharedInstance]getContentWithEntity:EntityCategoryModel];
}

-(id)init{
    self = [super init];
    
    if (self) {
        //todo: identificar quando foi a primeira vez que o app abriu
        
        [self loadOrCreateCategories];
    }
    
    return self;
}

-(NSString*)getDocumentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    return documentDirectory;
}

-(void)loadOrCreateCategories{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categoryDefault" ofType:@"plist"];
    
    NSDictionary *plistContent = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    defaultCategoryDictionary = [[NSDictionary alloc]initWithDictionary:[plistContent objectForKey:@"categories"]];
    
    BOOL hasContent = [[CoreDataService sharedInstance] hasContentWithEntity:EntityCategoryModel];
    
    if (!hasContent) {
        NSArray *allKeys = [defaultCategoryDictionary allKeys];
        
        for (NSString *key in allKeys) {
            NSString *imageName = [defaultCategoryDictionary objectForKey:key];
            NSEntityDescription *entity = [[CoreDataService sharedInstance] createEntityDescriptionWithName:EntityCategoryModel];
            CategoryModel *categoryModel = (CategoryModel*)[[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:[[CoreDataService sharedInstance]context]];
            categoryModel.name = key;
            NSString *imagePath = [NSString stringWithFormat:@"img/category_icons/%@.png",imageName];
            if (!imagePath) {
                imagePath = @"img/category_icons/default.png";
            }
            categoryModel.imageName = imagePath;
            
            NSString *identifier = [NSString stringWithFormat:@"%lu",(unsigned long)[allKeys indexOfObject:key]];
            
//            if ([key isEqualToString:@"default"]) {
//                identifier = @"default";
//            }
            
            categoryModel.identifier = identifier;
        }
        
        [[CoreDataService sharedInstance] saveContext];
    }
}

-(CategoryModel*)getCategoryById:(NSString*)identifier{
    
    NSString *query = [NSString stringWithFormat:@"identifier == %@", identifier];
    
    if ([NSString isStringEmpty:identifier] || [identifier isEqualToString:@"default"]) {
        query = [NSString stringWithFormat:@"name == '%@'", @"default"];
    }
    
    NSArray *list =  [[CoreDataService sharedInstance] getContentWithEntity:EntityCategoryModel AndQuery:query];
    if (list.count > 0) {
        return [list lastObject];
    }
    
    return nil;
}

-(CategoryModel*)getLastCategoryModelWithQuery:(NSString*)query{
    
    NSArray *list = [[CoreDataService sharedInstance] getContentWithEntity:EntityCategoryModel AndQuery:query];
    
    if (list > 0) {
        return [list lastObject];
    }
    
    return nil;
}

-(CategoryModel*)getDefaultCategory{
    NSString *query = [NSString stringWithFormat:@"name == %@", @"'default'"];
    NSArray *list =  [[CoreDataService sharedInstance] getContentWithEntity:EntityCategoryModel AndQuery:query];
    if (list.count > 0) {
        return [list lastObject];
    }
    
    return nil;
}

@end
