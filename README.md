## WZYTransition

### 使用方法:
```markdown
1.当前控制器和SecondDetailViewController控制器都需要实现- (UIView *)WZYTransitionView方法,不能放回nil;
- (UIView *)WZYTransitionView {
return self.imageView;
}
2.使用自定义的Push方法WZY_PushViewController,如果需要支持手势popGesture传YES;
SecondDetailViewController *firstDetailVC = [[SecondDetailViewController alloc] init];
firstDetailVC.image = self.imageView.image;
[self.navigationController WZY_PushViewController:firstDetailVC popGesture:YES];
```
![](https://github.com/wuzhiyong168/WZYTransition/blob/master/WZYTransition.gif)
