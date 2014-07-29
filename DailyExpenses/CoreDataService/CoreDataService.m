//
//  CoreDataService.m
//  WannaBeTheBatCoreSample
//
//  Created by renan veloso silva on 29/04/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "CoreDataService.h"

@implementation CoreDataService

@synthesize context;

SynthensizeSingleTon(CoreDataService)

-(id)init{
    self = [super init];
    
    if (self) {
        [self context];
    }
    
    return self;
}

#pragma mark - coreData
-(void)saveContext{
    NSError *error;
    if (![context save:&error]) {
        NSDictionary *informacoes = [error userInfo];
        NSArray *multiplosError = [informacoes objectForKey:NSDetailedErrorsKey];
        if (multiplosError) {
            for (NSError *error in multiplosError) {
                NSLog(@"error: %@", [error userInfo]);
            }
        }else{
            NSLog(@"error: %@", informacoes);
        }
    }else{
        ///
    }
}

-(NSManagedObjectModel*)managedObjectModel{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

-(NSPersistentStoreCoordinator *)coordinator{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentsDirectory];
    NSURL *localBancoDados = [pastaDocuments URLByAppendingPathComponent:@"SpentDataBase.sqlite"];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDados options:options error:nil];
    return coordinator;
}

-(NSURL*)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectContext *)context{
    if (context != nil) {
        return context;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self coordinator];
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}

-(BOOL)hasContentWithEntity:(NSString*)entityStr{
    NSArray *result = [self getContentWithEntity:entityStr];
    
    if (result == nil || result.count == 0) {
        return NO;
    }
    
    return YES;
}

-(NSArray*)getContentWithEntity:(NSString*)entityStr{
    return [self getContentWithEntity:entityStr AndQuery:nil];

}

-(NSArray*)getContentWithEntity:(NSString*)entityStr AndQuery:(NSString*)query{
    NSEntityDescription *entity = [self createEntityDescriptionWithName:entityStr];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];

    request.sortDescriptors = [NSArray arrayWithObject:descriptor];;
    
    if (![NSString isStringEmpty:query]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
        request.predicate = predicate;
    }
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    return result;
}

-(NSEntityDescription*)createEntityDescriptionWithName:(NSString*)entityStr{
    return [NSEntityDescription entityForName:entityStr inManagedObjectContext:context];
}

-(NSManagedObject*)createManagedObjectWithName:(NSString*)entityStr{
    NSEntityDescription *entity = [self createEntityDescriptionWithName:entityStr];
    return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

@end
