#import <UIKit/UIKit.h>
#import <NotificationCenter/NCWidgetController.h>

@interface _NCWidgetViewController : UIViewController
@end

%hook _NCWidgetViewController

- (void)viewDidLoad {
    %orig;
    NSLog(@"[Tweak1] viewDidLoad called");

    // Verificar si el método view está disponible para evitar errores de forward declaration
    if ([self respondsToSelector:@selector(view)]) {
        NSLog(@"[Tweak1] self responds to view");

        // Crear el efecto de desenfoque
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        // Añadir el efecto de desenfoque como fondo
        [self.view insertSubview:blurEffectView atIndex:0];
        NSLog(@"[Tweak1] Blur effect added");

        // Crear las pestañas y añadirlas a la vista
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Today", @"Notifications"]];
        segmentedControl.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 30);
        [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0; // Selecciona la primera pestaña por defecto
        [self.view addSubview:segmentedControl];
        NSLog(@"[Tweak1] Segmented control added");

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
        NSLog(@"[Tweak1] Views added");

        // Mostrar solo la vista de hoy inicialmente
        todayView.hidden = NO;
        notificationsView.hidden = YES;
        NSLog(@"[Tweak1] Initial view set");
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    UIView *todayView = [self.view viewWithTag:1];
    UIView *notificationsView = [self.view viewWithTag:2];

    if (sender.selectedSegmentIndex == 0) {
        todayView.hidden = NO;
        notificationsView.hidden = YES;
        NSLog(@"[Tweak1] Today view shown");
    } else {
        todayView.hidden = YES;
        notificationsView.hidden = NO;
        NSLog(@"[Tweak1] Notifications view shown");
    }
}

%end
