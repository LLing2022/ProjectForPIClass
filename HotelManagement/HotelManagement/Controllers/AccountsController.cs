using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Security;
using HotelManagement.Models;
using System.Web.Security;
using Membership = HotelManagement.Models.Membership;

namespace HotelManagement.Controllers
{
    public class AccountsController : Controller
    {
        // GET: Accounts
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Membership model1)
        {
            using (var context=new HotelManagementDBEntities ())
            {
                bool isValidUser=context.Users.Any(x=>x.name == model1.UserName && x.password == model1.UserPassword);
                if (isValidUser)
                {
                    FormsAuthentication.SetAuthCookie(model1.UserName, false);
                    return RedirectToAction("Index", "Users");
                }
               
                ModelState.AddModelError("", "Invaild username and password");
                return View();
            }
           
        }
        public ActionResult Signup()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Signup(User model1)
        {
          
            if (!IsPasswordValid(model1.password))
            {
                ModelState.AddModelError("", "Password needs to be at least 8 characters long and include at least one special character");
                return View();
            }

            if (!IsValidEmail(model1.emailAddress))
            {
                ModelState.AddModelError("", "Invalid email format. Please use a valid email adress.");
                return View();
            }
            using (var context=new HotelManagementDBEntities())
            {
                context.Users.Add(model1);
                context.SaveChanges();
            }
            return RedirectToAction("Login");
            
        }
      

        public ActionResult StaffLogin()
        {
            return View();
        }
        [HttpPost]
        public ActionResult StaffLogin(Staff model1)
        {
            if (!IsValidEmail(model1.email))
            {
                ModelState.AddModelError("", "Invalid email format. Please enter a valid email adress");
                return View();
            }
           
            using (var context = new HotelManagementDBEntities())
            {
                var user = context.Staffs.SingleOrDefault(s => s.email == model1.email);

                if (user != null)
                {
                    if (user.password == model1.password)
                    {
                        if (user.isManager)
                        {
                            // Manager login logic
                            FormsAuthentication.SetAuthCookie(model1.email, false);
                            return RedirectToAction("Index", "Staffs");
                        }
                        else
                        {
                            // Staff login logic
                            FormsAuthentication.SetAuthCookie(model1.email, false);
                            return RedirectToAction("Index", "Users");
                        }
                    }
                }

                ModelState.AddModelError("", "Invalid username or password");
                return View();
            }
        }

        private bool IsValidEmail(string email)
        {
            return email.ToLower().Contains("@");
        }
        private bool IsPasswordValid(string password)
        {
            return password.Length >= 8 && ContainsSpecialCharacter(password);
        }
        private bool ContainsSpecialCharacter(string input)
        {
            string specialCharacters = "!@#$%^&*()-+=[]{}|;:',.<>?/";
            return input.Any(c => specialCharacters.Contains(c));
        }
        private bool IsValidPhoneNumber(string phoneNumber)
        {
            // Remove dashes and spaces from the phone number
            string cleanedNumber = new string(phoneNumber.Where(char.IsDigit).ToArray());

            // Check if the cleaned phone number is 10 digits long
            return cleanedNumber.Length == 10;
        }
    }
}