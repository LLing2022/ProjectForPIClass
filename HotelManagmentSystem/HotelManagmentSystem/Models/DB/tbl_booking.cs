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
    
    public partial class tbl_booking
    {
        public int booking_id { get; set; }
        public string customer_name { get; set; }
        public string customer_address { get; set; }
        public string customer_email { get; set; }
        public string customer_phone_no { get; set; }
        public System.DateTime booking_from { get; set; }
        public System.DateTime booking_to { get; set; }
        public int payment_type { get; set; }
        public int assigned_room { get; set; }
        public Nullable<byte> no_of_members { get; set; }
        public Nullable<decimal> total_amount { get; set; }
    
        public virtual tbl_room tbl_room { get; set; }
        public virtual tbl_payment_type tbl_payment_type { get; set; }
    }
}