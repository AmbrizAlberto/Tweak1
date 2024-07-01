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

        // Eliminar el efecto de desenfoque (opcional, si no deseas el efecto de desenfoque)
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIVisualEffectView class]]) {
                [subview removeFromSuperview];
            }
        }

        // Crear un fondo estilo iOS 9.3.5
        self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]; // Ajusta el color según sea necesario

        // Crear las pestañas y añadirlas a la vista
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Today", @"Notifications"]];
        segmentedControl.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 30);
        [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0; // Selecciona la primera pestaña por defecto
        [self.view addSubview:segmentedControl];
        NSLog(@"[Tweak1] Segmented control added");

        // Crear contenedor para las diferentes secciones (solo un contenedor en este caso)
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80)];
        contentView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:contentView];
        NSLog(@"[Tweak1] Content view added");

        // Simular la apariencia de iOS 9.3.5 - Puedes personalizar este contenido según lo necesites
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, contentView.frame.size.width - 40, 40)];
        label.text = @"Content styled like iOS 9.3.5";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:label];
        NSLog(@"[Tweak1] Content styled");

        // Mostrar solo la vista inicialmente
        contentView.hidden = NO;
        NSLog(@"[Tweak1] Initial view set");
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    // Implementa el cambio de segmento según sea necesario
    NSLog(@"[Tweak1] Segment changed: %ld", (long)sender.selectedSegmentIndex);
}

%end
