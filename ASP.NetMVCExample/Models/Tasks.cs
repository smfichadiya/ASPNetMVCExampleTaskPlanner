//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ASP.NetMVCExample.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tasks
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Tasks()
        {
            this.TaskLinkers = new HashSet<TaskLinkers>();
            this.TaskLinkers1 = new HashSet<TaskLinkers>();
        }
    
        public int TaskID { get; set; }
        public Nullable<int> SubContractorID { get; set; }
        public Nullable<int> TaskTypeID { get; set; }
        public int ProjectID { get; set; }
        public string Description { get; set; }
        public long DurationTicks { get; set; }
        public Nullable<System.DateTime> ActualStartDate { get; set; }
        public Nullable<System.DateTime> ActualEndDate { get; set; }
        public System.DateTime CreationDate { get; set; }
    
        public virtual Companys Companys { get; set; }
        public virtual Projects Projects { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TaskLinkers> TaskLinkers { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TaskLinkers> TaskLinkers1 { get; set; }
        public virtual TaskTypes TaskTypes { get; set; }
    }
}
