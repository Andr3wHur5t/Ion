//
//  InfoBarView.h
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonCore.h>

@interface InfoBarView : IonView

#pragma mark Elements
/**
 * Our details button.
 */
@property (strong, nonatomic, readonly) IonInterfaceButton *detailsButton;

/**
 * Our Label.
 */
@property (strong, nonatomic, readonly) IonLabel* label;

@end
