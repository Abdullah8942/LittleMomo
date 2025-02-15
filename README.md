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



**Working**

****ERD Diagram the projects functional requirements****

**Link**:https://dbdiagram.io/d/67a60d60263d6cf9a065319e

**Authentication using Firebase**
https://console.firebase.google.com/u/0/project/little-momo-9fbc2/authentication/users


**postman**
**link** https://app.getpostman.com/join-team?invite_code=a216fadb49273712d1d7785b5a7c1e576aab65745ef95f5024e4cf2f2e1ad4db&target_code=391ff250ca62ab40964d4b80b8c20e2b

**CRUD**

// 🛒 Get All Products
router.get('/products', async (req, res) => {
  const products = await Product.find();
  res.json(products);
});

// 🛒 Get Product by ID
router.get('/products/:id', async (req, res) => {
  const product = await Product.findById(req.params.id);
  res.json(product);
});

// 🛒 Create New Product (Admin Only)
router.post('/products', async (req, res) => {
  const product = new Product(req.body);
  await product.save();
  res.status(201).json(product);
});

// 🛒 Update Product (Admin Only)
router.put('/products/:id', async (req, res) => {
  const product = await Product.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json(product);
});

// 🛒 Delete Product (Admin Only)
router.delete('/products/:id', async (req, res) => {
  await Product.findByIdAndDelete(req.params.id);
  res.json({ message: 'Product deleted' });
});

// 📦 Create New Order
router.post('/orders', async (req, res) => {
  const order = new Order(req.body);
  await order.save();
  res.status(201).json(order);
});

// 📦 Get All Orders (Admin & Customer)
router.get('/orders', async (req, res) => {
  const orders = await Order.find().populate('user_id').populate('products.product_id');
  res.json(orders);
});

// 📦 Get Order by ID
router.get('/orders/:id', async (req, res) => {
  const order = await Order.findById(req.params.id).populate('user_id').populate('products.product_id');
  res.json(order);
});

// 📦 Update Order Status (Admin/Delivery)
router.put('/orders/:id/status', async (req, res) => {
  const order = await Order.findByIdAndUpdate(req.params.id, { status: req.body.status }, { new: true });
  res.json(order);
});

// 📦 Delete Order
router.delete('/orders/:id', async (req, res) => {
  await Order.findByIdAndDelete(req.params.id);
  res.json({ message: 'Order deleted' });
});

// 🚚 Assign Delivery to Order
router.post('/deliveries', async (req, res) => {
  const delivery = new Delivery(req.body);
  await delivery.save();
  res.status(201).json(delivery);
});

// 🚚 Get All Deliveries
router.get('/deliveries', async (req, res) => {
  const deliveries = await Delivery.find().populate('order_id').populate('delivery_person_id');
  res.json(deliveries);
});

// 🚚 Update Delivery Status
router.put('/deliveries/:id/status', async (req, res) => {
  const delivery = await Delivery.findByIdAndUpdate(req.params.id, { status: req.body.status }, { new: true });
  res.json(delivery);
});

// 🚚 Get Routes for Delivery
router.get('/routes', async (req, res) => {
  const routes = await Route.find();
  res.json(routes);
});

// 🚚 Create New Route (Admin Only)
router.post('/routes', async (req, res) => {
  const route = new Route(req.body);
  await route.save();
  res.status(201).json(route);
});

// 👤 Register New User
router.post('/users', async (req, res) => {
  const user = new User(req.body);
  await user.save();
  res.status(201).json(user);
});

// 👤 Get All Users (Admin Only)
router.get('/users', async (req, res) => {
  const users = await User.find();
  res.json(users);
});

// 👤 Get User by ID
router.get('/users/:id', async (req, res) => {
  const user = await User.findById(req.params.id);
  res.json(user);
});

// 👤 Update User Profile
router.put('/users/:id', async (req, res) => {
  const user = await User.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json(user);
});

// 👤 Delete User (Admin Only)
router.delete('/users/:id', async (req, res) => {
  await User.findByIdAndDelete(req.params.id);
  res.json({ message: 'User deleted' });
});





 
**Contributing**
We welcome contributions to improve Little-Momo! Feel free to submit pull requests or report issues.

License

This project is licensed under the MIT License.

Developed by Team Little-Momo 🚀

