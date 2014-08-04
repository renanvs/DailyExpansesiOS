//
//  CDVMainPlugin.m
//  DailyExpenses
//
//  Created by renan veloso silva on 03/08/14.
//
//

#import "CDVMainPlugin.h"
#import "FormCDVViewController.h"
#import "HistoryCDVViewController.h"

@implementation CDVMainPlugin

-(void)GoToHistory:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    HistoryCDVViewController *hvc = [[HistoryCDVViewController alloc] init];
    [[self.viewController findTopRootViewController] presentViewController:hvc animated:YES completion:nil];
}

-(void)GoToForm:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    FormCDVViewController *fvc = [[FormCDVViewController alloc] init];
    [[self.viewController findTopRootViewController] presentViewController:fvc animated:YES completion:nil];
}

@end
