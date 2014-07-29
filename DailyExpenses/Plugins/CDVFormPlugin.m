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
    CDVPluginResult *result = nil;
    
    ItemModel *desireItem = [[ItemManager sharedInstance] getLastItem];
    if (!desireItem) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        return;
    }
    
    NSDictionary *itemJson = [JsonUtility itemModelToItemDic:desireItem];
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:itemJson];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

-(void)Back:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    [[self.viewController findTopRootViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
