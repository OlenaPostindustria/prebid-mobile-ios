/*   Copyright 2018-2021 Prebid.org, Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

@interface UIView (PBMExtensions)

- (void)PBMAddFillSuperviewConstraints
    NS_SWIFT_NAME(PBMAddFillSuperviewConstraints());

- (void)PBMAddConstraintsFromCGRect:(CGRect)rect
    NS_SWIFT_NAME(PBMAddConstraintsFromCGRect(_:));

- (void)PBMAddCropAndCenterConstraintsWithInitialWidth:(CGFloat)initialWidth initialHeight:(CGFloat)initialHeight
    NS_SWIFT_NAME(PBMAddCropAndCenterConstraints(initialWidth:initialHeight:));

- (void)PBMAddBottomRightConstraintsWithMarginSize:(CGSize)marginSize;

- (void)PBMAddBottomRightConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize
    NS_SWIFT_NAME(PBMAddBottomRightConstraints(viewSize:marginSize:));

- (void)PBMAddBottomLeftConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize
    NS_SWIFT_NAME(PBMAddBottomLeftConstraints(viewSize:marginSize:));

- (void)PBMAddTopRightConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize
    NS_SWIFT_NAME(PBMAddTopRightConstraints(viewSize:marginSize:));

- (void)PBMAddTopLeftConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize
NS_SWIFT_NAME(PBMAddTopLeftConstraints(viewSize:marginSize:));

- (void)PBMLogViewHierarchy;

- (BOOL)pbmIsVisible;

- (BOOL)pbmIsVisibleInView:(UIView *)inView;

- (BOOL)pbmIsVisibleInViewLegacy:(UIView *)inView;

@end
