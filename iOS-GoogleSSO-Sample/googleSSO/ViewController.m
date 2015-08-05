//
//  ViewController.m
//  googleSSO
//
//  Created by justin on 2015/7/30.
//  Copyright (c) 2015年 justin. All rights reserved.
//

#import "ViewController.h"
#import "googleInfoViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet GIDSignInButton *googleSignInBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].clientID = @"17905925778-ieocc16q2bnmqmjsn8fn0bo8l6lk0m43.apps.googleusercontent.com";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    NSLog(@"signInWillDispatch");
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - GoogleSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"userId:%@ ", user.userID);
    NSLog(@"idToken:%@", user.authentication.idToken);
    NSLog(@"name:%@", user.profile.name);
    NSLog(@"email:%@", user.profile.email);
    NSLog(@"hasimage:%@", @(user.profile.hasImage));
    NSLog(@"imageUrl:%@", [user.profile imageURLWithDimension:50]);

    if (user.userID && [user.userID length] > 0) {
        [self performSegueWithIdentifier: @"googleSignIn" sender:self];
    }
}

#pragma mark - IBAction

- (IBAction)tapGoogleSSO:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
}

@end
