//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace ASP.NetMVCExample.Models
{
    public partial class UserValidation
    {
        public string Code { get; set; }
        public int UserID { get; set; }
        public System.DateTime TimeIssued { get; set; }

        public virtual User User { get; set; }
    }
}
