//
//  ViewController.m
//  googlePlus
//
//  Created by justin on 2015/8/5.
//  Copyright (c) 2015年 justin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet GPPSignInButton *signInButton;
@property (nonatomic, weak) IBOutlet UIButton *logoutBtn;
@property (nonatomic, weak) IBOutlet GPPSignInButton *googleLogInBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *googleLogInLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 120, self.googleLogInBtn.bounds.size.height)];
    googleLogInLbl.text = @"google Login";
    googleLogInLbl.backgroundColor = [UIColor lightGrayColor];
    googleLogInLbl.textAlignment = NSTextAlignmentCenter;
    [self.googleLogInBtn addSubview:googleLogInLbl];

    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = @"932229984048-5bppk4s20cglaqi1mb98tit7vqqteio5.apps.googleusercontent.com";
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // defined in GTLPlusConstants.h
                     nil];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.delegate = self;
    [self refreshInterfaceBasedOnSignIn];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error:(NSError *)error {
    if (error) {
        //Handle Error
        NSLog(@"error:%@", error);
    } else {
        [self refreshInterfaceBasedOnSignIn];
        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
        plusService.retryEnabled = YES;
        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
        NSLog(@"clinicId:%@", [GPPSignIn sharedInstance].clientID);
        NSLog(@"idToken:%@", [GPPSignIn sharedInstance].idToken);

        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];

        // *4. Use the "v1" version of the Google+ API.*
        plusService.apiVersion = @"v1";

        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                        //Handle Error
                    } else {
                        NSLog(@"Email= %@",[GPPSignIn sharedInstance].authentication.userEmail);
                        NSLog(@"GoogleID=%@",person.identifier);
                        NSLog(@"User Name=%@",[person.name.givenName stringByAppendingFormat:@" %@",person.name.familyName]);
                        NSLog(@"Gender=%@",person.gender);
                    }
                }];

    }
}

-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        self.logoutBtn.hidden = NO;
        self.googleLogInBtn.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
        self.logoutBtn.hidden = YES;
        self.googleLogInBtn.hidden = NO;
        // Perform other actions here
    }
}

- (IBAction)signOut:(id)sender {
    [[GPPSignIn sharedInstance] signOut];
    [self refreshInterfaceBasedOnSignIn];
}

@end
