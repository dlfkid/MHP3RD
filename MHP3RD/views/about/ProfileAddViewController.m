//
//  ProfileAddViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/3/29.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "ProfileAddViewController.h"
#import "Communicator.h"
#import "HunterProfile.h"
#define KEYBOARDHEIGHT 300
#define LABELHEIGHT 40
#define LABELWIDTH 60
#define GAP 10
#define TEXTFIELDWIDTH 150
#define NAVBAR 64
#define TABBAR 48
#define SCREENWIDTH self.view.frame.size.width
#define SCREENHEIGHT self.view.frame.size.height
@interface ProfileAddViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

{
    UIScrollView *backgroundScroll;
    int keyBoardHeight;
    UIImagePickerController * imagePicker;
    UIImage *headerIcon;
}

@end

@implementation ProfileAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backgroundScroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    backgroundScroll.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + KEYBOARDHEIGHT);
    backgroundScroll.scrollEnabled = true;
    backgroundScroll.showsVerticalScrollIndicator = false;
    backgroundScroll.bounces = false;
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = true;
    
    [self.view addSubview:backgroundScroll];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:false];
    self.navigationItem.title = @"添加猎人信息";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self configureUI];
    [self configureNavBarButton];
    [self configureTapGesture];
    [self configureImageAddButton];
    [self placeData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setText field

- (void)configureUI {
    NSArray *labelNames = @[@"名字",@"称号",@"村任务",@"集会下",@"集会上",@"等级",@"简介"];
    for(int i = 0; i < labelNames.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH - LABELWIDTH - TEXTFIELDWIDTH - GAP)/2,i * (LABELHEIGHT + GAP) + TEXTFIELDWIDTH, LABELWIDTH, LABELHEIGHT)];
        label.text = labelNames[i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(label.frame.origin.x + LABELWIDTH + GAP, label.frame.origin.y, TEXTFIELDWIDTH, LABELHEIGHT)];
        text.tag = 200 + i;
        text.layer.borderWidth = 1;
        text.layer.cornerRadius = 3;
        text.delegate = self;
        [backgroundScroll addSubview:label];
        [backgroundScroll addSubview:text];
    }
    UITextField *textfield = [backgroundScroll viewWithTag:206];
    [textfield setFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y, TEXTFIELDWIDTH, LABELHEIGHT * 3)];
}

- (void)configureNavBarButton {
    if(self.modifyHunterProfile == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonConfirmAction:)];
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonSaveAction:)];
    }
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(buttonCancelAction:)];
}

- (void)configureBottomButton {
    NSArray *buttonNames = @[@"确认",@"取消"];
    for (int i = 0; i < buttonNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [backgroundScroll addSubview:button];
    }
    UIButton *confirm = [backgroundScroll viewWithTag:100];
    [confirm addTarget:self action:@selector(buttonConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    confirm.frame = CGRectMake((SCREENWIDTH/2 - LABELWIDTH - GAP), SCREENHEIGHT + 3 * LABELHEIGHT - GAP, LABELWIDTH, LABELHEIGHT);
    UIButton *cancel = [backgroundScroll viewWithTag:101];
    [cancel addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancel.frame = CGRectMake(confirm.frame.origin.x + 2 * GAP + LABELWIDTH, confirm.frame.origin.y, LABELWIDTH, LABELHEIGHT);
}

- (void)placeData {
        if(self.modifyHunterProfile != nil) {
        NSString *QuestVillage = [NSString stringWithFormat:@"%f",_modifyHunterProfile.questVillage];
        NSString *QuestGuildLow = [NSString stringWithFormat:@"%f",_modifyHunterProfile.questGuildLow];
        NSString *QuestGuildHigh = [NSString stringWithFormat:@"%f",_modifyHunterProfile.questGuildHigh];
        NSString *HunterRank = [NSString stringWithFormat:@"%f",_modifyHunterProfile.HunterRank];
        
        NSArray *data = @[_modifyHunterProfile.name,_modifyHunterProfile.title,QuestVillage,QuestGuildLow,QuestGuildHigh,HunterRank,_modifyHunterProfile.selfIntroduce];
        for(int i = 0; i < 7; i++) {
            UITextField *textField = [backgroundScroll viewWithTag:200 + i];
            textField.text = data[i];
        }
    }
}

- (void)configureImageAddButton {
    UIButton *imageAdd = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - 100)/2, GAP, 100, 100)];
    imageAdd.layer.borderWidth = 1;
    imageAdd.layer.cornerRadius = 4;
    [imageAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [imageAdd addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchDown];
    [backgroundScroll addSubview:imageAdd];
}

- (void)presentActionSheet:(UIButton *)sender {
    UIAlertController *addAction = [[UIAlertController alloc]init];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消选择");
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍摄头像");
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:true completion:nil];
        }
    }];
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"从相册选择头像");
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:true completion:nil];
        }
    }];
    [addAction addAction:library];
    [addAction addAction:camera];
    [addAction addAction:cancel];
    
    [self presentViewController:addAction animated:true completion:nil];
}

- (void)buttonSaveAction:(UIButton *)sender {
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < 7; i++) {
        UITextField *textfield = [backgroundScroll viewWithTag:200 + i];
        if([self isBlankString:textfield.text]){
            [self presentViewController:[self configureAlertView] animated:true completion:nil];
            return;
        }
        [array addObject:textfield.text];
    }
    
    NSString *picURL;
    
    if(headerIcon != nil){
        NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString *picPath = [[sandBoxPath objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"header%d.png",self.ID]];
        [UIImagePNGRepresentation(headerIcon)writeToFile:picPath   atomically:YES];
        picURL = picPath;
    }
    if (self.modifyHunterProfile.pic != nil && headerIcon == nil) {
        picURL = self.modifyHunterProfile.pic;
        UIImage *image = [UIImage imageWithContentsOfFile:picURL];
        [UIImagePNGRepresentation(image)writeToFile:picURL   atomically:YES];
    }
    
    NSString *name = array[0];
    int16_t ID = self.modifyHunterProfile.ID;
    NSString *title = array[1];
    float QV = [[NSString stringWithFormat:@"%@",array[2]] floatValue];
    float GL = [[NSString stringWithFormat:@"%@",array[3]] floatValue];
    float GH = [[NSString stringWithFormat:@"%@",array[4]] floatValue];
    float HR = [[NSString stringWithFormat:@"%@",array[5]] floatValue];
    NSString *brief = array[6];
    HunterProfile *HP = [[HunterProfile   alloc]initWithName:name andID:ID andTitile:title andSelfy:brief andQV:QV andQGL:GL andQGH:GH andHR:HR andPic:picURL];
    [Communicator changeHunterProfile:HP];
    NSNotification *note = [[NSNotification alloc]initWithName:@"ProfileAdded" object:nil userInfo:nil];
    NSNotification *save = [[NSNotification alloc]initWithName:@"profileChange" object:HP userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:save];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)buttonConfirmAction:(UIButton *)sender {
    
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < 7; i++) {
        UITextField *textfield = [backgroundScroll viewWithTag:200 + i];
        if([self isBlankString:textfield.text]){
            [self presentViewController:[self configureAlertView] animated:true completion:nil];
            return;
        }
        [array addObject:textfield.text];
    }
    
    NSString *picURL;
    
    if(headerIcon != nil){
        NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString *picPath = [[sandBoxPath objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"header%d.png",self.ID]];
        [UIImagePNGRepresentation(headerIcon)writeToFile:picPath   atomically:YES];
        picURL = picPath;
    }
    
    NSString *name = array[0];
    int16_t ID = self.ID;
    NSString *title = array[1];
    float QV = [[NSString stringWithFormat:@"%@",array[2]] floatValue];
    float GL = [[NSString stringWithFormat:@"%@",array[3]] floatValue];
    float GH = [[NSString stringWithFormat:@"%@",array[4]] floatValue];
    float HR = [[NSString stringWithFormat:@"%@",array[5]] floatValue];
    NSString *brief = array[6];
    HunterProfile *HP = [[HunterProfile   alloc]initWithName:name andID:ID andTitile:title andSelfy:brief andQV:QV andQGL:GL andQGH:GH andHR:HR andPic:picURL];
    [Communicator AddHunterProfile:HP];
    NSNotification *note = [[NSNotification alloc]initWithName:@"ProfileAdded" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)buttonCancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField.frame.origin.y + textField.frame.size.height > SCREENHEIGHT - keyBoardHeight){
        CGFloat move = (textField.frame.origin.y + textField.frame.size.height) - (SCREENHEIGHT - keyBoardHeight);
        [backgroundScroll setContentOffset:CGPointMake(0, backgroundScroll.contentOffset.y + move) animated:true];
    }
}

//configure alert view
-(UIAlertController *)configureAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"输入内容为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"没有输入内容");
    }];
    [alert addAction:noAction];
    return alert;
}

//判断文本框中是否输入了内容
- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
} 

- (void)keyBoardShow:(NSNotification *)sender {
    NSDictionary *userInfo = [sender userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    keyBoardHeight = height;
}

#pragma mark - CancelEditByTap

- (void)configureTapGesture {
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelTapAction:)];
    cancelTap.cancelsTouchesInView = false;
    [backgroundScroll addGestureRecognizer:cancelTap];
}

- (void)cancelTapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:true];
}

#pragma mark - UIimagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [imagePicker dismissViewControllerAnimated:true completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH - 100)/2, GAP, 100, 100)];
    header.image = image;
    headerIcon = image;
    [backgroundScroll addSubview:header];
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
