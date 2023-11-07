using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Net.Mail;
using HotelManagmentSystem.Models;
using HotelManagmentSystem.Models.DB;
using System.Security.Cryptography;
using System.Text;

namespace HotelManagmentSystem.Controllers
{
    public class HomeController : Controller
    {

        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult sendmail()
        {


            return View();
        }
        [HttpPost]
        public ActionResult sendmail(HotelManagmentSystem.Models.MailModel _objModelMail)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    MailMessage mail = new MailMessage();
                    mail.To.Add(_objModelMail.To);
                    //mail.From = new MailAddress(_objModelMail.From);
                    mail.From = new MailAddress("hotelservcies@gmail.com", "hotel");
                    mail.Subject = _objModelMail.Subject;
                    string Body = _objModelMail.Body;
                    mail.Body = Body;
                    mail.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "smtp.gmail.com";
                    smtp.Port = 587;
                    smtp.UseDefaultCredentials = false;

                    smtp.Credentials = new NetworkCredential("hotelservcies@gmail.com", "hotelservcies007");
                    smtp.EnableSsl = true;
                    smtp.Send(mail);

                    return View("sendmail");
                }
                else
                {
                    return View();
                }
            }
            catch (Exception)
            {

                return View("sendmail");
            }

        }
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(tbl_user objuser)
        {
            HMSDBEntities obj = new HMSDBEntities();

            var user = obj.tbl_user.Where(x => x.email == objuser.email && x.user_password == objuser.user_password ).FirstOrDefault();
            ViewBag.u = user;
            
            try
            {
                ViewBag.email = user.email;
                ViewBag.password = user.user_password;
                Session["Name"] = user.username;
            }
            catch (Exception)
            {


            }
            
            if (user.user_level != 3)
            {
                return RedirectToAction("Index", "Home");
            }
            else if(user.user_level == 3)
            {
                return RedirectToAction("Home", "View");
            }
            else
            {
                return View();
            }
        }
        public ActionResult Signup()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Signup(tbl_user model1)
        {
           

            if (string.IsNullOrWhiteSpace(model1.username) || string.IsNullOrWhiteSpace(model1.email) || string.IsNullOrWhiteSpace(model1.user_password))
            {
                ModelState.AddModelError("", "Username,Email , Password cannot be empty.");
                return View();
            }

            if (!IsPasswordValid(model1.user_password))
            {
                ModelState.AddModelError("", "Password needs to be at least 8 characters long and include at least one special character");
                return View();
            }

            if (!IsValidEmail(model1.email))
            {
                ModelState.AddModelError("", "Invalid email format. Please use a valid email adress.");
                return View();
            }
            using (var context = new HMSDBEntities())
            {
              //  model1.user_password = HashPassword(model1.user_password);
                model1.user_level = 3;
                context.tbl_user.Add(model1);
                context.SaveChanges();
            }
            return RedirectToAction("Login");

        }

        private string HashPassword(string password)
        {
            // Use a secure hash function like bcrypt, Argon2, etc.
            // For simplicity, let's use a simple hash here (not recommended for production)
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        private bool VerifyPassword(string enteredPassword, string hashedPassword)
        {
            // Compare the entered password with the hashed password
            string hashedEnteredPassword = HashPassword(enteredPassword);
            return string.Equals(hashedEnteredPassword, hashedPassword);
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

