//
//  CDVFormPlugin.m
//  DailyExpenses
//
//  Created by renan veloso silva on 27/06/14.
//
//

#import "CDVFormPlugin.h"

@implementation CDVFormPlugin

-(void)Populate:(CDVInvokedUrlCommand*)command{
    //[self.commandDelegate runInBackground:^{
        CDVPluginResult *result = nil;
        
        ItemModel *desireItem = [[ItemManager sharedInstance] getLastItem];
        if (!desireItem) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            return;
        }
        
        NSDictionary *itemJson = [JsonUtility itemModelToItemDic:desireItem];
        
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:itemJson];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
   // }];
    
}

-(void)Back:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    [[self.viewController findTopRootViewController] dismissViewControllerAnimated:YES completion:nil];
}

-(void)SendItem:(CDVInvokedUrlCommand*)command{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = nil;
        
        if (command.arguments.count == 0 || [[command.arguments lastObject] isKindOfClass:[NSNull class]] ) {
            NSLog(@"Error: sem item model para salvar/atualizar");
            return;
        }
        
        NSString *jsonStr = [command.arguments lastObject];
        NSDictionary *dic = [JsonUtility jsonStringToDictionary:jsonStr];
        ItemModel *model = [[ItemManager sharedInstance] CreateOrUpdateItemWithDictionary:dic];
        NSDictionary *modelDic = [JsonUtility itemModelToItemDic:model];
        
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:modelDic];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
        
    }];
    
    [[self.viewController findTopRootViewController]dismissViewControllerAnimated:YES completion:nil];
    
}

@end
