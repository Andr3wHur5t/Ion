//
//  PersonCell.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "PersonCell.h"
#import <IonCore/IonCore.h>

@interface  PersonCell ()

@property (strong, nonatomic, readwrite) IonView *personImage;

@property (strong, nonatomic, readonly) UILabel *nameLabel;

@end

@implementation PersonCell

@synthesize nameLabel = _nameLabel;
@synthesize personImage = _personImage;
@synthesize model = _model;

- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.themeElement = @"cell";
        
        // Add Sub views
        [self addSubview: self.personImage];
        [self addSubview: self.nameLabel];
    }
    return self;
}


- (UILabel *)nameLabel {
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.themeClass = @"nameLabel";
        
        // Position and size
        [_nameLabel setSizeGuidesWithLeft: self.personImage.rightMargin
                                    right: self.rightAutoPadding
                                      top: self.topAutoPadding
                                andBottom: self.bottomAutoPadding];
        [_nameLabel setGuidesWithLocalHoriz: _nameLabel.originGuideHoriz
                                  localVert: _nameLabel.centerGuideVert
                                 superHoriz: self.personImage.rightMargin
                               andSuperVert: self.centerGuideVert];
    }
    return _nameLabel;
}


- (IonView *)personImage {
    if ( !_personImage ) {
        _personImage = [[IonView alloc] init];
        _personImage.themeClass = @"profileImage";
        _personImage.frame = (CGRect){ (CGPoint){ 0, 0 } , (CGSize){ 65, 65 }};
        
        // Position
        [_personImage setGuidesWithLocalHoriz: _personImage.originGuideHoriz
                                    localVert: _personImage.centerGuideVert
                                   superHoriz: self.leftAutoPadding
                                 andSuperVert: self.centerGuideVert];
    }
    return _personImage;
}

- (void) setModel:(PHProfile *)model {
    if ( ![model isKindOfClass: [PHProfile class]] )
        return;
    
    _model = model;
    
    self.nameLabel.text = _model.name;

    dispatch_async( [[self class] imageLoadingQueue], ^{
        UIImage *profileImage = [UIImage imageNamed: _model.profileImageName ];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [self.personImage setBackgroundImage: profileImage];
        });
    });
}

+ (dispatch_queue_t) imageLoadingQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t queue_token;
    dispatch_once( &queue_token , ^{
        queue = dispatch_queue_create( "imageLoading", 0 );
    });
    return queue;
    
}
@end
