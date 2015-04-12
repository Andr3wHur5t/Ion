//
//  AppDelegate.m
//  TableViewProto
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupRouter {
  [super setupRouter];
  [self addViewController:[ViewController class]
             toRouterPath:@[@"Main"]];
}

- (void)configureFirstRealViewController:(void (^)(IonViewController *))finished {
  [super configureFirstRealViewController:finished];
  [[IACLink linkWithURLString:@"proto:///main" andReason:@"startup"] invoke];
  // Go to da page
}

- (NSDictionary *)defaultTheme {
  return @{
           @"colors":@{
               
               },
           @"styles":@{
               @"children": @{
                   @"id_main":@{
                       @"background": @{ @"type": @"color", @"name": @"#F5F5F5" },
                       },
                   @"tableView": @{
                       @"background": @{ @"type": @"color", @"name": @"#F0F" },
                       @"children": @{
                           @"cell": @{
                               @"styleMargin": @{@"height": @5, @"width": @10},
                               @"background": @{ @"type": @"color", @"name": @"#F00" },
                               },
                           @"cls_one": @{
                                @"background": @{ @"type": @"color", @"name": @"#0F0" },
                               }
                           }
                       }
                   }
               }
           };
}
@end
