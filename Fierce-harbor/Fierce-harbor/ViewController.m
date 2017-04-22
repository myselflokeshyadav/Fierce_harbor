//
//  ViewController.m
//  Fierce-harbor
//
//  Created by Lucky  on 4/22/17.
//  Copyright © 2017 Lucky . All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
@interface ViewController ()<DetailViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *serviceProviderListArr;

@end


@implementation ViewController

- (NSMutableArray*)serviceProviderListArr{
    
    
    if (!_serviceProviderListArr) {
        
        _serviceProviderListArr = [[NSMutableArray alloc] init];
    }
    
    return _serviceProviderListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Master";
    [self apiCall];

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)updateCollectionView{
    [self.collectionView reloadData];
}

-(void)apiCall{
    [self showActivityIndicator:@"Getting List..."];

    __weak ViewController *weakSelf = self;

    [[ApiHandler sharedApiHandler]getServiceProviderListApiHandlerWithCallBlock:^(id data, NSError *error) {
        if ([data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data) {
                BaseClass *baseClass = [[BaseClass alloc] initWithDictionary:dict];
                [[weakSelf serviceProviderListArr] addObject:baseClass];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self hideActivityIndicator];
                [[weakSelf collectionView] reloadData];
            });
            
        }
    } profileId:nil];
    
}
#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_serviceProviderListArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *identifier = @"CollectionViewCell";
     
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    BaseClass *obj = [_serviceProviderListArr objectAtIndex:indexPath.row];
    if (obj.isfav) {
        cell.favImg.image = [UIImage imageNamed:@"Favorite"];
    }else{
        cell.favImg.image = [UIImage imageNamed:@""];
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:obj.profilePicture]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.profileImg.image = image;
                [cell setNeedsLayout];
            });
        }
    });
    
     return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailController.object = [self.serviceProviderListArr objectAtIndex:indexPath.row];
    [detailController setDelegate:self];
    [self.navigationController pushViewController:detailController animated:YES];

}

#pragma mark - MBProgressHUD Delegate
- (void)showActivityIndicator:(NSString*)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
}
- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
