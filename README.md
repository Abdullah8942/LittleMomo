Little-Momo: The Little Momo Ordering & Delivery App

Overview

Little-Momo is a mobile application designed to streamline the ordering and delivery process for Little Momo, a popular eatery in Gujranwala. Currently, 70% of its orders come through third-party platforms like Foodpanda, which charge high commissions. This app eliminates the need for such platforms by enabling direct transactions between customers and the shop, increasing profitability and enhancing customer satisfaction.

Key Goals

✔ Reduce dependency on Foodpanda and eliminate commission fees.✔ Provide a seamless ordering experience for customers.✔ Optimize delivery routes for faster and more efficient deliveries.✔ Increase sales through discounts and promotions.✔ Empower the seller with full control over orders, pricing, and analytics.

Target Users

Customers who frequently order from Little Momo.

Shop owner and staff for managing orders and customer interactions.

Delivery personnel for route optimization and efficient deliveries.

Key Features

Customer Features

Easy menu browsing with item descriptions and prices.

Direct ordering system (No third-party involvement).

Real-time order tracking.

Exclusive discounts and promotions on special occasions.

Multiple payment options (Secure online payments & Cash-on-Delivery).

Seller/Admin Features (Admin Panel)

Dashboard for managing orders, customers, and earnings.

Real-time order notifications.

Menu customization (Add, edit, or remove items).

Discount & promotional offer management.

Sales and revenue analytics.

Delivery Features

Optimized delivery routes using Google Maps API.

Order assignment & live status updates.

Performance and earnings tracking.

Technologies & Frameworks Used

Frontend (Mobile App)

Flutter (Dart) – For cross-platform mobile development.

Firebase Authentication – For user authentication (Customers, Sellers, and Delivery Personnel).

Google Maps API – For real-time delivery route optimization.

Backend & Database

Firebase Firestore – Storing orders, users, and products.

Firebase Cloud Functions / Node.js – Backend logic for order processing.

Google Maps API – Calculating the shortest delivery paths.

Web-Based Admin Panel

Flutter Web – For the seller dashboard.

Firebase Firestore – Managing orders, products, and analytics.

Getting Started

Follow these steps to clone and run the Little-Momo project on your local machine.

Prerequisites

Ensure you have the following installed on your system:

Flutter SDK (Latest version) - Install Flutter

Dart SDK (Included with Flutter)

Android Studio or Visual Studio Code (With Flutter plugins)

Git (For cloning the repository)

Clone the Repository

Open your terminal or command prompt and run:

git clone https://github.com/Abdullah8942/Little-Momo.git
cd Little-Momo

Setting Up the Mobile App

cd app
flutter pub get
flutter run

This will fetch the required dependencies and launch the app.

Setting Up the Admin Panel (Web)

cd web_admin
flutter pub get
flutter run -d chrome

This will start the seller dashboard in a web browser.

Backend & Database Setup

The app uses Firebase as the backend. To configure Firebase:

Create a Firebase project in the Firebase Console.

Set up Firestore Database and Authentication.

Download the google-services.json file for Android and GoogleService-Info.plist for iOS.

Place them in the respective directories (android/app/ for Android and ios/Runner/ for iOS).

Deploy Firebase Cloud Functions using:

cd functions
npm install
firebase deploy

Contributing

We welcome contributions to improve Little-Momo! Feel free to submit pull requests or report issues.

License

This project is licensed under the MIT License.

Developed by Team Little-Momo 🚀

