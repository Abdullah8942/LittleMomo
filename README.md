# Little Momo - Food Ordering App

Little Momo is a delicious momo (dumpling) ordering app that allows users to browse, select, and order their favorite momos.

## Features

- **Splash Screen**: Attractive splash screen with Little Momo logo and name.
- **Authentication**: User login and signup screens.
- **Home Screen**: Welcome message with username, categories, popular products, and special offers.
- **Menu**: Browse all products with ability to add items to cart.
- **Add Product**: Ability for admins to add new products with image, name, category, and price.
- **SQLite Database**: Local storage for products and cart items.
- **Beautiful UI**: Modern and user-friendly interface inspired by popular food delivery apps.

## Technical Implementation

- **Flutter**: Built with Flutter framework for cross-platform compatibility.
- **SQLite**: Local database for storing product and cart information.
- **Navigation**: Uses bottom navigation bar and drawer for easy navigation.
- **Fragments**: Implements fragments (PopularProductsFragment) for reusable UI components.
- **Form Validation**: Input validation on login and signup forms.
- **Image Picker**: Ability to select product images from gallery.
- **UI Components**: Custom-designed cards, buttons, and input fields.

## Getting Started

1. Ensure you have Flutter installed on your machine.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Launch the app with `flutter run`.

## Default Login

For testing purposes, you can use the following credentials:
- Username: admin
- Password: password

## Admin vs User

The app has two types of users:
- **Admin**: Can add new products and manage the menu.
- **User**: Can browse products and place orders.

## Dependencies

- `flutter`: The main framework
- `sqflite`: Local database
- `image_picker`: For selecting images from gallery
- `intl`: For date formatting
- `fluttertoast`: For showing toast messages
- `shared_preferences`: For storing user preferences
- `provider`: For state management

## Future Improvements

- Firebase integration for user authentication
- Online database for product storage
- Payment gateway integration
- Order tracking feature
- User reviews and ratings
- Push notifications for order updates

