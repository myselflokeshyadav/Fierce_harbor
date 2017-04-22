//
//  DetialViewController.h
//  Fierce-harbor
//
//  Created by Lucky  on 4/22/17.
//  Copyright © 2017 Lucky . All rights reserved.
//

@protocol DetailViewDelegate <NSObject>
-(void)updateCollectionView;
@end

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(strong,nonatomic)BaseClass *object;
@property(nonatomic,assign)id<DetailViewDelegate>delegate;

@end
