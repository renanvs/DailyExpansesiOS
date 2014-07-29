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
    CDVPluginResult *result = nil;
    
    NSArray *allItens = [[ItemManager sharedInstance] getAllItens];
    NSArray *allItensJson = [JsonUtility itemListToJsonArrayList:allItens];
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:allItensJson];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

-(void)GetAllCategories:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    NSArray *allCategories = [[CategoryManager sharedInstance] getAllCategories];
    NSArray *allCategoriesJson = [JsonUtility categoryListToJsonArrayList:allCategories];
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:allCategoriesJson];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
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
    
    [[self.viewController findTopRootViewController] presentViewController:formViewController animated:YES completion:nil];
}

@end
