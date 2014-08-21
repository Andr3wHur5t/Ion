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
    IonInterfaceButton* button;
    IonLabel* testLabel;
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
    //self.view.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    //imgView.themeID = @"simpleStyle";
    
    // Set the image using the image manager
    button = [[IonInterfaceButton alloc] initWithFileName: @"Hamburger"];
   //[button setEnabled: false];
    button.frame = (CGRect){ (CGPoint){ 18, 50 + 2 }, (CGSize){30,30}};
    [self.view addSubview: button];
    
    [self.view setBackgroundImageUsingKey: @"aspect"];
    
    [self makeTestLabel];
}

- (void) viewWillAppear:(BOOL)animated {
    // Set the overriden background.
    [self doTests];
    
    // Call this last
    [super viewWillAppear: animated];
}

- (void) makeTestLabel {
    testLabel = [[IonLabel alloc] initWithFrame: (CGRect){ CGPointZero, (CGSize){ self.view.frame.size.width - 18*6, 40}}];
    testLabel.center = (CGPoint){ self.view.frame.size.width / 2 , 25 };
    //testLabel.text = @"Lorem ipsum dolor sit amet consectetur adipiscing elit";
    testLabel.text = @"People";
    [self.view addSubview: testLabel];
}

/** = = = = = = = = = = = = Tests = = = = = = = = = = = = = = =  */

- (void) doTests {
    sc = [IonSimpleCache cacheWithName:@"Test Cache" withLoadCompletion:^(NSError *error) {
        [self test];
    }];
    
    [self performSelector:@selector(remove) withObject:NULL afterDelay:5];
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
    
    /*for ( NSString* path in paths ) {
        randomContent = [NSNumber numberWithInt: arc4random()];
        [sc setObject: [[NSData dataFromNumber: randomContent] toBase64] forKey:path withCompletion: NULL];
        for ( NSInteger i = 10 + arc4random() % 50; i >= 0; --i )
            [sc objectForKey:path withResultBlock: ^(id object) {} ];
    }*/

}

- (void) remove {
    sc = NULL;
}

- (void) shouldLayoutSubviews {
    [super shouldLayoutSubviews];
    CGSize s = self.view.frame.size;
    s.height = 50;
    imgView.frame = (CGRect) {CGPointZero,s};
}

/** = = = = = = = = = = = = End Tests = = = = = = = = = = = = = = =  */

/**
 * This is where we should free our recreateable data, or save data to disk.
 */
- (void) shouldFreeNonCriticalObjects {
    
}

@end
