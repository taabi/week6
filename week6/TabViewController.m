//
//  TabViewController.m
//  week6
//
//  Created by taabi on 7/10/14.
//  Copyright (c) 2014 taabi. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()
@property (weak, nonatomic) IBOutlet UIView *tabView;
- (IBAction)panTabView:(UIPanGestureRecognizer *)sender;
@property (nonatomic,strong) UIViewController *mainViewController;
@property (nonatomic,strong) UIViewController *menuViewController;

@end

@implementation TabViewController

CGPoint originalCenter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIViewController *menuView = self.viewControllers[1];
    [self.tabView addSubview:menuView.view];
    
    UIViewController *mainView = self.viewControllers[0];
    [self.tabView addSubview:mainView.view];
    
    self.mainViewController = mainView;
    self.menuViewController = menuView;
    
    self.menuViewController.view.frame = CGRectMake(20, 20,320*.9,568*.9);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)panTabView:(UIPanGestureRecognizer *)panGestureRecognizer {
    NSLog(@"Workingg");
    CGPoint point=[panGestureRecognizer locationInView:self.tabView];
    CGPoint translation=[panGestureRecognizer translationInView:self.tabView];
    CGPoint velocity=[panGestureRecognizer velocityInView:self.tabView];
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        //NSLog(@"moving");
        
        originalCenter = self.mainViewController.view.center;
        NSLog(@"center: %@", NSStringFromCGPoint(originalCenter));
        
        
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        NSLog(@"velocity: %@", NSStringFromCGPoint(velocity));
        
        //NSLog(@"point: %@",NSStringFromCGPoint(point));
        //NSLog(@"Translation: %@",NSStringFromCGPoint(translation));
        self.mainViewController.view.center = CGPointMake(originalCenter.x + translation.x, self.mainViewController.view.center.y);
        
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        //NSLog(@"center: %@", NSStringFromCGPoint(originalCenter));
        NSLog(@"Translation: %@",NSStringFromCGPoint(translation));
        
        if(translation.x > 0){
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1 options:0 animations:^{
                self.mainViewController.view.center = CGPointMake(originalCenter.x+260, self.mainViewController.view.center.y);
            } completion:nil];
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1 options:0 animations:^{
                self.menuViewController.view.frame = CGRectMake(0, 0,320,568);
            } completion:nil];

            
        }
        else if (translation.x < 0){
        [UIView animateWithDuration:0.7 delay:.2 usingSpringWithDamping:.8 initialSpringVelocity:1 options:0 animations:^{
            self.mainViewController.view.center = CGPointMake(originalCenter.x-260,originalCenter.y);
            self.menuViewController.view.frame = CGRectMake(20, 20,320*.9,568*.9);
        } completion:Nil];
            
            

            
        }
        
    }
    
    
}
@end
