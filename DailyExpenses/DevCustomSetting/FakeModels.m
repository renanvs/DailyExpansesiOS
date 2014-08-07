//
//  FakeModels.m
//  DailyExpenses
//
//  Created by renanvs on 7/31/14.
//
//

#import "FakeModels.h"

@implementation FakeModels

+(void)createVariatyOfItens{
    CoreDataService *cs = [CoreDataService sharedInstance];
    ItemModel *item0 = (ItemModel*)[cs createManagedObjectWithName:EntityItemModel];
    item0.dateCreated = [[DateUtility sharedInstance] getDateWithStringDate:@"2010-03-18 12:12:12"];
    item0.dateSpent = [[DateUtility sharedInstance] getDateWithStringDate:@"2014-08-07"];
    item0.isMoneyIn = [NSNumber numberWithBool:YES];
    item0.label = @"salario";
    item0.notes = @"vem que vem";
    item0.parcel = @"1";
    item0.value = @"1000";
    item0.identifier = @"_0";
  
    ItemModel *item1 = (ItemModel*)[cs createManagedObjectWithName:EntityItemModel];
    item1.dateCreated = [[DateUtility sharedInstance] getDateWithStringDate:@"2011-03-17 12:12:12"];
    item1.dateSpent = [[DateUtility sharedInstance] getDateWithStringDate:@"2011-03-17"];
    item1.isCreditCard = [NSNumber numberWithBool:YES];
    item1.isMoneyOut = [NSNumber numberWithBool:YES];
    item1.label = @"agua";
    item1.notes = @"isso é um teste de copo";
    item1.parcel = @"3";
    item1.value = @"33.55";
    item1.identifier = @"_1";
    item1.category = [self categoryWithName:@"cocktail"];

    ItemModel *item2 = (ItemModel*)[cs createManagedObjectWithName:EntityItemModel];
    item2.dateCreated = [[DateUtility sharedInstance] getDateWithStringDate:@"2011-01-01 12:12:12"];
    item2.dateSpent = [[DateUtility sharedInstance] getDateWithStringDate:@"2011-01-01"];
    item2.isCreditCard = [NSNumber numberWithBool:YES];
    item2.isMoneyOut = [NSNumber numberWithBool:YES];
    item2.label = @"viagem";
    item2.notes = @"viagem muito loca";
    item2.parcel = @"10";
    item2.value = @"2.5";
    item2.identifier = @"_2";
    item2.category = [self categoryWithName:@"airplane"];
    
    ItemModel *item3 = (ItemModel*)[cs createManagedObjectWithName:EntityItemModel];
    item3.dateCreated = [[DateUtility sharedInstance] getDateWithStringDate:@"2014-12-22 12:12:12"];
    item3.dateSpent = [[DateUtility sharedInstance] getDateWithStringDate:@"2014-12-22"];
    item3.isMoney = [NSNumber numberWithBool:YES];
    item3.isMoneyOut = [NSNumber numberWithBool:YES];
    item3.label = @"notebook macbook";
    item3.notes = @"apple é foda";
    item3.parcel = @"15";
    item3.value = @"3499.99";
    item3.identifier = @"_3";
    item3.category = [self categoryWithName:@"pc"];
    
    ItemModel *item4 = (ItemModel*)[cs createManagedObjectWithName:EntityItemModel];
    item4.dateCreated = [[DateUtility sharedInstance] getDateWithStringDate:@"2014-12-22 12:12:12"];
    item4.dateSpent = [[DateUtility sharedInstance] getDateWithStringDate:@"2014-12-22"];
    item4.isDebitCard = [NSNumber numberWithBool:YES];
    item4.isMoneyOut = [NSNumber numberWithBool:YES];
    item4.label = @"desktop";
    item4.notes = @"computador de mesa";
    item4.parcel = @"6";
    item4.value = @"2999.99";
    item4.identifier = @"_4";
    item4.category = [self categoryWithName:@"pc"];
    
    [cs saveContext];
    
}

+(CategoryModel*)categoryWithName:(NSString*)name{
    NSString *query = [NSString stringWithFormat:@"name == '%@'",name];
    CategoryModel *cat = [[CategoryManager sharedInstance] getLastCategoryModelWithQuery:query];
    if (!cat){
        cat = (CategoryModel*)[[CoreDataService sharedInstance] createManagedObjectWithName:EntityCategoryModel];
        cat.name = @"Padrao";
        cat.imageName = @"icon_default";
        cat.identifier = @"007";
    }
    return cat;
}

@end
