1. Get a configuration file

 * 填寫appname和boundleID會產生一個plist
 * 再下載GoogleService-Info.plist

2. Use CocoaPods

 * pod 'Google/SignIn' //可以參照Refer

3. 把剛下載的GoogleService-Info.plist移到target裡面

4. 在Project > Target > Info > URL

 * 在URL建立一個新的item再把剛剛GoogleService-Info.plist裡的REVERSED_CLIENT_ID貼到URL Schemes欄位
 * 另外同樣把你的bundle identifier貼到URL Schemes欄位

5. Enable sign-in

- 在AppDelegate
```
#import <Google/SignIn.h>
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}
```
 - 在vc.h
```
#import <GoogleSignIn.h>
#import <GoogleSignIn/GIDSignInButton.h>
@interface ViewController : UIViewController <GIDSignInUIDelegate, GIDSignInDelegate>
```
 - 在vc.m
```
 - (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].clientID = @"17905925778-ieocc16q2bnmqmjsn8fn0bo8l6lk0m43.apps.googleusercontent.com";
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"userId:%@ ", user.userID);
    NSLog(@"idToken:%@", user.authentication.idToken);
    NSLog(@"name:%@", user.profile.name);
    NSLog(@"email:%@", user.profile.email);
    NSLog(@"hasimage:%@", @(user.profile.hasImage));
    NSLog(@"imageUrl:%@", [user.profile imageURLWithDimension:50]);
}
```
 - Logout
```
 [[GIDSignIn sharedInstance] signOut];
```
PS.use 
```
pod try Google 
```
可以產生一個google的範例

### Refer URL
* [Google SignIn] https://developers.google.com/identity/sign-in/ios/
* [Cocoapods 官網] http://cocoapods.org/
* [Cocoapods 中文教學] http://4tyone.blogspot.tw/2013/09/cocoapods_4.html
