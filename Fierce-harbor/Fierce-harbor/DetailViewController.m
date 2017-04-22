//
//  DetailViewController.m
//  Fierce-harbor
//
//  Created by Lucky  on 4/22/17.
//  Copyright © 2017 Lucky . All rights reserved.
//



#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation DetailViewController
@synthesize object = _object;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_object != nil) {
        [self apiCallProfileId:[NSString stringWithFormat:@"%d",(int)_object.internalBaseClassIdentifier]];
    }
    // Do any additional setup after loading the view.
}
- (IBAction)favoriteBtnAction:(id)sender {
    [self.object setIsfav:YES];
    if ([self delegate]) {
        [self.delegate updateCollectionView];
    }
}

#pragma mark - Api call for Profile information

-(void)apiCallProfileId:(NSString*)Id{
    [self showActivityIndicator:@"Getting List..."];
    
    __weak DetailViewController *weakSelf = self;
    
    [[ApiHandler sharedApiHandler]getServiceProviderListApiHandlerWithCallBlock:^(id data, NSError *error) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            _object.fullName = [NSString stringWithFormat:@"%@ %@", [data valueForKey:@"first_name"],[data valueForKey:@"last_name"]];
            _object.profile_picture = [data valueForKey:@"profile_picture"];
        }

        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicator];
            [weakSelf setupInformation];
        });
    } profileId:Id];

}
#pragma mark - Set up Information

-(void)setupInformation{
    self.title = _object.fullName;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_object.profile_picture]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _profileImage.image = image;
                [self.view setNeedsLayout];
            });
        }
    });

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
