//
//  ViewController.m
//  TableViewProto
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "ViewController.h"
#import "TVPCellOne.h"
#import "TVPDataOne.h"

@interface ViewController ()

@property (strong, nonatomic, readonly) IonTableView *table;

@property (strong, nonatomic, readonly) FODataModel *dataModel;

@end

@implementation ViewController

@synthesize table = _table;
@synthesize dataModel = _dataModel;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.themeID = @"main";
  // Do any additional setup afUter loading the view, typically from a nib.
  [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IonTableView *)table {
  if ( !_table ) {
    _table = [[IonTableView alloc] init];
    
    [_table setGuidesWithLocalHoriz:_table.originGuideHoriz
                          localVert:_table.originGuideVert
                         superHoriz:self.view.originGuideHoriz
                          superVert:[IonApplication sharedApplication].statusBarHeightGuide
                               left:self.view.originGuideHoriz
                              right:self.view.sizeGuideHoriz
                                top:self.view.originGuideVert
                          andBottom:self.view.sizeGuideVert];
    
    _table.dataModel = self.dataModel;
    [_table bindDataClass:[TVPDataOne class]
              toCellClass:[TVPCellOne class]];
    
    [self commitInitial];
    [self performBlock:^{
      [self commitSecondary];
    } afterDelay:2.0f];
    
  }
  return _table;
}



- (FODataModel *)dataModel {
  if ( !_dataModel )
    _dataModel = [[FODataModel alloc] init];
  return _dataModel;
}


#pragma mark Tests
- (void)commitInitial {
  for ( NSUInteger i = 0; i < 20; ++i)
    [self.dataModel addData:[[TVPDataOne alloc] init]];
}

- (void)commitSecondary {
  [self.dataModel removeAllData];
//  for ( NSUInteger i = 0; i < 20; ++i)
//    [self.dataModel addData:[[TVPDataOne alloc] initWithCls:@"one"]];
}
@end
