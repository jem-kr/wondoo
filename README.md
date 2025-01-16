# Wondoo  
A web platform for coffee product sales and one-day class bookings.

## 🛠 Project Overview  
**Category**: Web Development  
**Name**: Wondoo  
**Duration**: Feb 15, 2021 – Mar 15, 2021 (4 weeks)  
**Team Size**: 3 members  
**Key Features**:  
- User registration/login with validation  
- Product purchase and payment integration (Import API)  
- One-day class reservation system  
- Admin features for managing business approval  

---

## 📋 Background and Purpose  
Coffee has become a daily ritual for modern people. With the rise of home cafés during the COVID-19 pandemic, demand for coffee beans and small group classes has surged. Wondoo offers consumers a rich coffee experience while enabling sellers to generate additional revenue through one-day classes.

---

## 💻 Tech Stack  
- **Frontend**: HTML, CSS, JavaScript, jQuery, Bootstrap  
- **Backend**: Java, Spring MVC, MyBatis  
- **Database**: Oracle, eXerd  
- **Server**: Apache Tomcat v9.0  
- **Tools**: Eclipse, VS Code, GitHub  
- **APIs**: Kakao, Daum, Import  

---

## 📐 Architecture  

### Class Structure  
<img src="https://user-images.githubusercontent.com/74857433/113928984-73931700-982a-11eb-9451-26f1d55fefa2.png" alt="Class Structure Diagram">  

### Database Schema  
<img src="https://user-images.githubusercontent.com/74857433/113760921-cf3da180-9751-11eb-9492-f252bd8c17d0.png" alt="Database Schema Diagram">

---

## 🔥 Key Features  
1. **User Management**  
   - Registration (with validation via JavaScript & AJAX)  
   - Login (standard & Kakao API integration)  
   - Profile management and account deletion  

2. **Product Features**  
   - Product browsing, cart management, and payment processing  

3. **One-Day Class Management**  
   - Booking, registration, and scheduling  

4. **Admin Panel**  
   - Business approval system  
   - User and product management  

---

## ✅ Todo List  
*Progress was shared through Notion.*

### Member  
*Focused on the features I worked on.*  
![Member Feature Progress](https://user-images.githubusercontent.com/74857433/113939037-61b77100-9836-11eb-915d-e26667b3ed43.png)

### Product  
*Focused on the features I worked on.*  
![Product Feature Progress](https://user-images.githubusercontent.com/74857433/113939474-03d75900-9837-11eb-8144-bcceeb9eae75.png)

---

## 🎥 Demo  

### Contents List  
1. **Sign Up/Account Deletion**  
2. **Login/Logout**  
3. **My Page & Profile Update**  
4. **Find Email and Password**  
5. Product List & Details  
6. Notice Board & Comments  
7. Kakao Chatbot Support  
8. Coffee Preference Test (Find Your Coffee)  
9. Add Product to Cart  
10. **Product Payment & History**  
11. Product Registration, Editing, Deletion  
12. One-Day Class List & Details  
13. One-Day Class Booking & History  
14. One-Day Class Registration, Editing, Deletion  
15. **Business Menu - Business Approval Request**  
16. **Admin Menu - Business Approval Management**  
17. **Admin Menu - User List (Regular/Business Members)**

---

## UI and Code  
### [Sign Up](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustInsertController.java)  
![dope1](https://user-images.githubusercontent.com/74857433/113341002-970c1c80-9367-11eb-8b78-639eee924c30.gif)  
* Users are categorized as non-members, regular members (buyers), and business members (sellers).  
* Sign-up forms and controllers are handled separately for regular and business members.  

### [Sign Up Validation](https://github.com/seeyoufriyay/cafe/blob/master/src/main/webapp/WEB-INF/customer/custInsert.jsp)  
![dope5](https://user-images.githubusercontent.com/74857433/113433568-f7827480-93ce-11eb-9e98-ee457c7a3a4b.gif)  
* Required fields: email, password, phone number, date of birth.  
* Profile image and address are optional.  
* Email duplication is checked asynchronously using JavaScript and Ajax.  
* Admin email (`admin@gmail.com`) is not allowed.  

### [Login, My Page, Profile Update](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustLoginController.java)  
![dope2](https://user-images.githubusercontent.com/74857433/113343982-7940b680-936b-11eb-8dc6-339fbc964cc5.gif)  
* Login can be done using basic or Kakao login for regular members.  
* My page displays user information and allows profile updates.  

### [Kakao Sign Up and Login](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/KakaoController.java)  
![dope4](https://user-images.githubusercontent.com/74857433/113430968-03455980-9416-11eb-921c-aaa7c53da486.gif)  
* Kakao Open API is used for Kakao login.  
* If the email is not registered, users are redirected to sign up.  

### [Find Email/Password](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/CustIdSearchController.java)  
![dope10](https://user-images.githubusercontent.com/74857433/113691469-68939600-9707-11eb-8e67-015f86a76eda.gif)  
* Users can find their email and password by verifying their information.  

### [Product Payment, Order History, Order Details](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/productOrder/controller/prOrderPaymentController.java)  
![dope3](https://user-images.githubusercontent.com/74857433/113346164-75fafa00-936e-11eb-9c82-a3f3cbf71757.gif)  
* Integrated Import API for easy payments.  
* Payment history can be accessed through [My Orders].  

### [Business Approval Request](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/seller/controller/SellAppController.java)  
![dope6_1](https://user-images.githubusercontent.com/74857433/113442688-09204800-93e0-11eb-8690-5a8538cfabbb.gif)  
* Business approval is required before listing products.  
* Admin approval is required before business members can start selling.  

### [Business My Page, Profile Update](https://github.com/seeyoufriyay/cafe/blob/master/src/main/webapp/WEB-INF/seller/sellUpdate.jsp)  
![dope11](https://user-images.githubusercontent.com/74857433/114024261-cb736180-98ae-11eb-8087-9325bdc3fe3b.gif)  
* Business members can view and edit their information from the My Page.  
* Profile data is fetched from the database and displayed.  

### [Admin: Business Approval Management](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/AdminChkController.java)  
![dope8](https://user-images.githubusercontent.com/74857433/113441916-99f62400-93de-11eb-96aa-9366e614ed0d.gif)  
* Admin can approve or reject business membership.  

### [Admin: User List](https://github.com/seeyoufriyay/cafe/blob/master/src/main/java/customer/controller/AdminListController.java)  
![dope9](https://user-images.githubusercontent.com/74857433/113451160-eea29a80-93f0-11eb-81df-3217be409eac.gif)  
* Admin can view the full list of regular and business members.  
* Admin can search by email, contact, or business status.  
