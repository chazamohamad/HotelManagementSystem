using System;
using HotelManagementSystem.DAL;

namespace HotelManagementSystem.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            UserRepository userRepo = new UserRepository();
            bool isValid = userRepo.SignInUser(username, password);

            if (isValid)
            {
                // Redirect to dashboard under admin
                Response.Redirect("~/Pages/Admin/Dashboard");
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
            }
        }
    }
}
