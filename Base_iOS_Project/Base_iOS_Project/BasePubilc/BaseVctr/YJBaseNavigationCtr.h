//
//  YJBaseNavigationCtr.h
//  youjie
//
//  Created by TDJR on 15/3/6.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBaseNavigationCtr : UINavigationController

- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition;

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;

/*目的：使用navigation controller push view controller，达到从底部升起的效果
 *aFromController,来自view controller，截取aFromController‘s view 作为背景，避免出现空白背景
 */
- (void)pushViewControllerFromVCtr: (UIViewController*)aFromController toVCtr:(UIViewController*)aToViewController;

/*目的：使用navigation controller pop view controller，达到从top降下的效果
 */
- (void)popViewController;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
