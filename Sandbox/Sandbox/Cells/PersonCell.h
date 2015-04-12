//
//  PersonCell.h
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonCore.h>
#import <PHData/PHData.h>

@interface PersonCell : IonView

@property (strong, nonatomic, readwrite) PHProfile *model;

@end
