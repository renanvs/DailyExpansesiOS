//
//  CDVHistoryPlugin.m
//  DailyExpenses
//
//  Created by renan veloso silva on 19/06/14.
//
//

#import "CDVHistoryPlugin.h"
#import "FormCDVViewController.h"

@implementation CDVHistoryPlugin

-(void)GetAllItens:(CDVInvokedUrlCommand*)command{
    
    //[self.commandDelegate runInBackground:^{
        CDVPluginResult *result = nil;
        NSArray *allItens = [[ItemManager sharedInstance] getAllItens];
        NSArray *allItensJson = [JsonUtility itemListToJsonArrayList:allItens];
        
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:allItensJson];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    //}];
}

-(void)GetAllCategories:(CDVInvokedUrlCommand*)command{
    //[self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = nil;
        
        NSArray *allCategories = [[CategoryManager sharedInstance] getAllCategories];
        NSArray *allCategoriesJson = [JsonUtility categoryListToJsonArrayList:allCategories];
        
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:allCategoriesJson];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
   // }];
}

-(void)ShowForm:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    if (command.arguments.count == 0 || [[command.arguments lastObject] isKindOfClass:[NSNull class]] ) {
        NSLog(@"Error: Sem o id do item, impossivel mostra o formulario");
        return;
    }
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    FormCDVViewController *formViewController = [[FormCDVViewController alloc] init];
    [[ItemManager sharedInstance] setItemIdentifier:[command.arguments lastObject]];
    
    //id obj = [self.viewController findTopRootViewController];
    
    [[self.viewController findTopRootViewController] presentViewController:formViewController animated:YES completion:nil];
}

-(void)Filter:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    if (command.arguments.count == 0 || [[command.arguments lastObject] isKindOfClass:[NSNull class]] ) {
        NSLog(@"Error: Sem o id do item, impossivel mostra o formulario");
        return;
    }
    
    NSString *jsonStr = [command.arguments lastObject];
    NSDictionary *dic = [JsonUtility jsonStringToDictionary:jsonStr];
    
    NSArray *itens = [[ItemManager sharedInstance] getItensWithFilterDictionary:dic];
    
    NSArray *itensF = [JsonUtility itemListToJsonArrayList:itens];
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:itensF];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

@end
