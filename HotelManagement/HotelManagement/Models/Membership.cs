using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HotelManagement.Models
{
    public class Membership
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string UserEmail { get; set; }
        public string UserPassword { get; set; }

        public int StaffId { get; set; }
        public string StaffName { get; set; }   
        public string StaffEmail { get; set; }
        public string StaffPassword { get; set; }

        public string StaffPhonenumber { get; set; }
        public bool IsManager { get; set; }


    }
}