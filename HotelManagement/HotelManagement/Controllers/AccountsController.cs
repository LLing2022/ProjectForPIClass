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
            using (var context = new HotelManagementDBEntities())
            {
                bool isValidStaff = context.Staffs.Any(s => s.name == model1.name && s.password == model1.password);
                if (isValidStaff)
                {
                    FormsAuthentication.SetAuthCookie(model1.name, false);
                    return RedirectToAction("Index", "Staffs");
                }

                ModelState.AddModelError("", "Invaild username and password");
                return View();
            }
        }

    }
}