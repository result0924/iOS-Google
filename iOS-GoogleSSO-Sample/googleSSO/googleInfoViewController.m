//
//  googleInfoViewController.m
//  googleSSO
//
//  Created by justin on 2015/7/30.
//  Copyright (c) 2015年 justin. All rights reserved.
//

#import "googleInfoViewController.h"
#import <GoogleSignIn.h>

@interface googleInfoViewController ()<GIDSignInDelegate>
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;

@end

@implementation googleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signInSilently];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"userId:%@ ", user.userID);
    NSLog(@"idToken:%@", user.authentication.idToken);
    NSLog(@"name:%@", user.profile.name);
    NSLog(@"email:%@", user.profile.email);
    NSLog(@"hasimage:%@", @(user.profile.hasImage));
    NSLog(@"imageUrl:%@", [user.profile imageURLWithDimension:50]);

    self.name.text = user.profile.name;
    self.email.text = user.profile.email;
    NSData *imageData = [NSData dataWithContentsOfURL:[user.profile imageURLWithDimension:60]];
    self.avatar.image = [UIImage imageWithData:imageData];
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [self performSegueWithIdentifier: @"noGoogleToken" sender:self];
}

@end
