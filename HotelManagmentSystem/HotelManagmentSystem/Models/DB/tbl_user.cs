//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HotelManagmentSystem.Models.DB
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_user
    {
        public int userid { get; set; }
        public string username { get; set; }
        public string email { get; set; }
        public string user_password { get; set; }
        public int user_level { get; set; }
    
        public virtual tbl_user_level tbl_user_level { get; set; }
    }
}