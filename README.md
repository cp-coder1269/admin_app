# Admin App

This application is designed for administrators to manage user requests, including approval and rejection actions. It provides a user-friendly interface to view and handle requests submitted through the User App, with integrated email notifications.

## Features

- **Request Management**: View and manage user requests, including details and status.
- **Approval and Rejection**: Approve or reject requests, with corresponding email notifications sent to users.
- **Request Status**: Track the status of requests (Pending, Approved, Rejected).

## Architecture

1. **Admin Interface**: Provides a web-based interface for administrators to interact with user requests.
2. **Node.js Backend**: Communicates with a Node.js backend service to handle database operations and email notifications.

## Setup

### 1. Clone the Repository

```sh
git clone https://github.com/cp-coder1269/admin_app.git
cd admin_app
```

### 2. Install Dependencies

```sh
npm install
```

### 3. Run the Application

Start the application:

```sh
npm start
```

## Usage

### Admin Flow

2. **View Requests**: Navigate to the requests dashboard to view all user requests with their details and current status.
3. **Approve or Reject Requests**:
   - Select a request and choose to approve or reject it.
   - An email notification will be sent to the user based on the action taken.
4. **Track Request Status**: Monitor the status of requests (Pending, Approved, Rejected) through the dashboard.

## Demonstrative Video

Watch a [demonstrative video](https://drive.google.com/file/d/1Gw1lmTPa-ulLNhDXvaelCUJnOo5vojem/view?usp=share_link) to see the Admin app in action.

## Troubleshooting

- **Database Connection Issues**: Verify that your MySQL server is running and properly configured on Node.js backend service.
- **Email Sending Issues**: Check your Amazon SES configuration in the `.env` file.
- **Application Errors**: Review the console output for any error messages and ensure that all dependencies are correctly installed.

## Contact

If you encounter any issues or have questions, please email me at cppal474@gmail.com.
