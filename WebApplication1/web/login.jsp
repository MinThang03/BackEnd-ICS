<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMsg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if ("admin".equals(email) && "admin".equals(password)) {
            response.sendRedirect("index.jsp");
            return;
        } else if ("user".equals(email) && "user".equals(password)) {
            response.sendRedirect("user_dashboard.jsp");
            return;
        } else {
            errorMsg = "Tài khoản hoặc mật khẩu không đúng!";
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - ICSS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
            body {
                background: linear-gradient(135deg, #8e44ad, #3498db);
                font-family: 'Segoe UI', sans-serif;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
            }

            .login-container {
                width: 900px;
                background-color: #fff;
                border-radius: 20px;
                overflow: hidden;
                display: flex;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            }

            .login-left {
                background-color: #ffffff;
                color: #2c3e50;
                flex: 1;
                padding: 40px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .login-left img {
                width: 300px;
                margin-bottom: 20px;
            }

            .login-left h5 {
                font-weight: 600;
                font-size: 18px;
                margin-bottom: 10px;
            }

            .login-left p {
                text-align: center;
                font-size: 14px;
                color: #555;
            }

            .login-right {
                flex: 1;
                padding: 40px;
                background: linear-gradient(145deg, #43cea2, #185a9d);
                color: white;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-right h3 {
                font-weight: bold;
                margin-bottom: 10px;
            }

            .login-right p {
                font-size: 14px;
                margin-bottom: 25px;
                opacity: 0.9;
            }

            .form-control {
                border-radius: 10px;
                border: none;
                padding: 12px;
            }

            .form-control:focus {
                box-shadow: 0 0 0 0.2rem rgba(255, 255, 255, 0.5);
            }

            .form-label {
                color: #fff;
                font-weight: 500;
            }

            .btn-login {
                background: #ffffff;
                border: none;
                border-radius: 10px;
                padding: 12px;
                color: #e67e22;
                font-weight: bold;
                transition: background 0.3s;
            }

            .btn-login:hover {
                background: #ff5858;
            }

            .remember-forgot {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
                color: #fff;
            }

            .remember-forgot a {
                color: #fff;
                text-decoration: underline;
            }

            .remember-forgot label {
                margin-left: 5px;
            }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-left">
            <img src="Img/logo.png" alt="Logo">
            <h5>Kết nối – Hiệu quả – Thành công</h5>
        </div>
        <div class="login-right">
            <h3>Welcome ICSS Company</h3>
            <p class="text-muted">Sign in to continue</p>
            <% if (!errorMsg.isEmpty()) { %>
                <div class="alert alert-danger py-2 mb-3" role="alert">
                    <%= errorMsg %>
                </div>
            <% } %>
            <form action="login.jsp" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email" placeholder="Nhập email">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu">
                </div>
                <div class="remember-forgot mb-3">
                    <div>
                        <input type="checkbox" id="remember"> <label for="remember">Remember me</label>
                    </div>
                    <a href="#" class="text-decoration-none">Forgot Password?</a>
                </div>
                <button type="submit" class="btn btn-login w-100">Login</button>
            </form>
        </div>
    </div>
</body>
</html>