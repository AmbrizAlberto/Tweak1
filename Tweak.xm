#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

// Hook para modificar el controlador principal del Centro de Notificaciones
%hook NCNotificationListViewController

- (void)viewDidLoad {
    %orig;

    // Crear el efecto de desenfoque
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // Añadir el efecto de desenfoque como fondo
    [self.view insertSubview:blurEffectView atIndex:0];

    // Crear las pestañas
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Today", @"Notifications"]];
    segmentedControl.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 30);
    [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0; // Selecciona la primera pestaña por defecto

    // Añadir las pestañas a la vista
    [self.view addSubview:segmentedControl];

    // Crear contenedores para las diferentes secciones
    UIView *todayView = [[UIView alloc] initWithFrame:self.view.bounds];
    todayView.backgroundColor = [UIColor clearColor];
    todayView.tag = 1;
    
    UIView *notificationsView = [[UIView alloc] initWithFrame:self.view.bounds];
    notificationsView.backgroundColor = [UIColor clearColor];
    notificationsView.tag = 2;

    // Añadir los contenedores a la vista
    [self.view addSubview:todayView];
    [self.view addSubview:notificationsView];

    // Mostrar solo la vista de hoy inicialmente
    todayView.hidden = NO;
    notificationsView.hidden = YES;
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    UIView *todayView = [self.view viewWithTag:1];
    UIView *notificationsView = [self.view viewWithTag:2];

    if (sender.selectedSegmentIndex == 0) {
        todayView.hidden = NO;
        notificationsView.hidden = YES;
    } else {
        todayView.hidden = YES;
        notificationsView.hidden = NO;
    }
}

%end
