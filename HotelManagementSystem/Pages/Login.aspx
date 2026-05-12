<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HotelManagementSystem.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hotel Management System | Login</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100vh;
            background:
                linear-gradient(rgba(6, 18, 40, 0.82), rgba(6, 18, 40, 0.82)),
                url('https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .overlay {
            position: absolute;
            width: 100%;
            height: 100%;
            backdrop-filter: blur(4px);
        }

        .main-container {
            position: relative;
            width: 1100px;
            height: 650px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            border-radius: 28px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 25px 60px rgba(0,0,0,0.35);
        }

        .left-panel {
            width: 55%;
            padding: 70px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }

        .logo {
            position: absolute;
            top: 40px;
            left: 60px;
            font-size: 22px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .logo span {
            color: #38bdf8;
        }

        .welcome-text {
            font-size: 18px;
            color: #cbd5e1;
            margin-bottom: 15px;
            letter-spacing: 2px;
        }

        .title {
            font-size: 68px;
            line-height: 1.05;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .description {
            font-size: 17px;
            color: #dbeafe;
            line-height: 1.9;
            width: 90%;
        }

        .features {
            display: flex;
            gap: 20px;
            margin-top: 45px;
            flex-wrap: wrap;
        }

        .feature-box {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.1);
            padding: 14px 20px;
            border-radius: 14px;
            font-size: 14px;
            color: #f8fafc;
        }

        .right-panel {
            width: 45%;
            background: rgba(255,255,255,0.96);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .login-card {
            width: 100%;
            max-width: 380px;
        }

        .login-title {
            font-size: 38px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: #64748b;
            margin-bottom: 35px;
            font-size: 15px;
        }

        .message {
            display: block;
            margin-bottom: 22px;
            padding: 14px;
            border-radius: 12px;
            background: #fee2e2;
            color: #dc2626;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 24px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-weight: 600;
            font-size: 14px;
        }

        .input-box {
            width: 100%;
            padding: 16px 18px;
            border: 1px solid #dbe2ea;
            border-radius: 14px;
            font-size: 15px;
            outline: none;
            transition: 0.3s ease;
            background: #f8fafc;
        }

        .input-box:focus {
            border-color: #0ea5e9;
            background: white;
            box-shadow: 0 0 0 5px rgba(14,165,233,0.12);
        }

        .login-btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #0284c7, #0f172a);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.35s ease;
            margin-top: 10px;
            box-shadow: 0 10px 25px rgba(2,132,199,0.28);
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 35px rgba(2,132,199,0.4);
        }

        .bottom-text {
            text-align: center;
            margin-top: 28px;
            color: #64748b;
            font-size: 14px;
        }

        .bottom-text span {
            color: #0284c7;
            font-weight: 600;
            cursor: pointer;
        }

        @media screen and (max-width: 980px) {

            .main-container {
                width: 95%;
                height: auto;
                flex-direction: column;
            }

            .left-panel,
            .right-panel {
                width: 100%;
            }

            .left-panel {
                padding: 80px 40px 50px;
            }

            .title {
                font-size: 48px;
            }

            .description {
                width: 100%;
            }

            .right-panel {
                padding: 45px 30px;
            }
        }
    </style>

</head>

<body>

    <div class="overlay"></div>

    <form id="form1" runat="server">

        <div class="main-container">

            <div class="left-panel">

                <div class="logo">
                    🏨 <span>HotelMS</span>
                </div>

                <div class="welcome-text">
                    PREMIUM HOTEL PLATFORM
                </div>

                <div class="title">
                    Smart Hotel<br />
                    Management
                </div>

                <div class="description">
                    Access your professional dashboard to manage hotel rooms,
                    reservations, customers, billing operations, and administrative
                    services through a modern secure platform.
                </div>

                <div class="features">
                    <div class="feature-box">Room Management</div>
                    <div class="feature-box">Reservations</div>
                    <div class="feature-box">Customer Tracking</div>
                    <div class="feature-box">Billing System</div>
                </div>

            </div>

            <div class="right-panel">

                <div class="login-card">

                    <div class="login-title">
                        Welcome Back
                    </div>

                    <div class="login-subtitle">
                        Login to continue to your dashboard
                    </div>

                    <asp:Label ID="lblMessage"
                        runat="server"
                        CssClass="message">
                    </asp:Label>

                    <div class="input-group">

                        <asp:Label ID="lblUsername"
                            runat="server"
                            Text="Username">
                        </asp:Label>

                        <asp:TextBox ID="txtUsername"
                            runat="server"
                            CssClass="input-box"
                            placeholder="Enter your username">
                        </asp:TextBox>

                    </div>

                    <div class="input-group">

                        <asp:Label ID="lblPassword"
                            runat="server"
                            Text="Password">
                        </asp:Label>

                        <asp:TextBox ID="txtPassword"
                            runat="server"
                            TextMode="Password"
                            CssClass="input-box"
                            placeholder="Enter your password">
                        </asp:TextBox>

                    </div>

                    <asp:Button ID="btnLogin"
                        runat="server"
                        Text="Login"
                        CssClass="login-btn"
                        OnClick="btnLogin_Click" />

                    <div class="bottom-text">
                        Hotel Management System © 2026
                    </div>

                </div>

            </div>

        </div>

    </form>

</body>
</html>