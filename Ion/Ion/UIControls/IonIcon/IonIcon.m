//
//  IonIcon.m
//  Ion
//
//  Created by Andrew Hurst on 9/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonIcon.h"
#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonTheme.h"
#import <IonData/IonData.h>

@implementation IonIcon
#pragma mark Constructors
/**
 * Default constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Framed constructor.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

/**
 * Constructs the icon view with the specified image.
 * @param {UIImage*} the icon.
 */
- (instancetype) initWithImage:(UIImage *)image {
    self = [self init];
    if ( self )
        [self setMaskImage: image renderMode: IonBackgroundRenderFilled];
    return self;
}

/**
 * Constructs the icon view with the specified image.
 * @param {NSString*} the key for the image.
 */
- (instancetype) initWithImageKey:(NSString *)imageKey {
    self = [self init];
    if ( self )
        [self setMaskImageUsingKey: imageKey inRenderMode: IonBackgroundRenderFilled];
    return self;
}

/**
 * General Construction.
 */
- (void) construct {
    self.themeElement = sIonIconViewKey;
}

#pragma mark Style Application
/**
 * Applies the style to the view.
 */
- (void) applyStyle:(IonStyle *)style {
    NSString *imageKey;
    
    // Size
    self.frame = (CGRect){ self.frame.origin, [style.configuration sizeForKey: sIonIconView_IconSize] };
    
    // Image
    imageKey = [style.configuration stringForKey: sIonIconView_IconImage];
    if ( imageKey && [imageKey isKindOfClass: [NSString class]] ) {
        [self setMaskImageUsingKey: imageKey inRenderMode: IonBackgroundRenderFilled];
    }
}

@end
