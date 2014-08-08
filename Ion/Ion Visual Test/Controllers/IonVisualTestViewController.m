//
//  IonVisualTestViewController.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonVisualTestViewController.h"

@interface IonVisualTestViewController () {
    UIView* imgView;
    IonSimpleCache* sc;
    IonImageManager* imageManager;
}

@end

@implementation IonVisualTestViewController

- (void) constructViews {
    [super constructViews];
    // Render Debug
    imgView = [[UIView alloc] init];
    [self.view addSubview:imgView];
    
    // Theme Testing
    imgView.themeConfiguration.themeClass = @"secondaryStyle";
    self.view.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    //imgView.themeID = @"simpleStyle";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    // Set the overriden background.
    
    [self.view setBackgroundImage: [UIImage imageNamed:@"aspect-test.png"] renderMode: IonBackgroundRenderFilled];
    
    sc = [imageManager cacheWithName:@"Test Cache" withLoadCompletion:^(NSError *error) {
        [self test];
    }];
}


-(void) appendItems:(NSInteger) count inGroup:(NSString*) group arr:(NSMutableArray*) arr {
    NSNumber* randomContent;
    randomContent = [NSNumber numberWithInt: arc4random()];
    
    for ( NSInteger i = count; i >= 0; --i )
        [arr addObject: [NSString stringWithFormat:@"%@/%i", group,  arc4random()]];
    
}

- (void) test {
    NSMutableArray* paths = [@[] mutableCopy];
    NSNumber* randomContent;
    
    [self appendItems:200 inGroup:@"here" arr: paths];
    [self appendItems:20 inGroup:@"lie" arr: paths];
    [self appendItems:100 inGroup:@"space" arr: paths];
    
    for ( NSString* path in paths ) {
        randomContent = [NSNumber numberWithInt: arc4random()];
        [sc setObject: [[NSData dataFromNumber: randomContent] toBase64] forKey:path withCompletion: NULL];
        //for ( NSInteger i = 10 + arc4random() % 50; i >= 0; --i )
         //   [sc objectForKey:path withResultBlock: ^(id object) {} ];
    }
   //[sc removeAllObjects:^(NSError *error) {
   //   NSLog(@"Removed all the things!");
   //}];
    
    [self performSelector:@selector(remove) withObject:NULL afterDelay:2];
}

- (void) remove {
    sc = NULL;
}
- (void) shouldLayoutSubviews {
    [super shouldLayoutSubviews];
    CGSize s = self.view.frame.size;
    s.height = 20 + 70;
    imgView.frame = (CGRect) {CGPointZero,s};
}


/**
 * This is where we should free our recreateable data, or save data to disk.
 */
- (void) shouldFreeNonCriticalObjects {
    
}

@end
