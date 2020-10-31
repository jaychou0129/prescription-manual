using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace PrescriptionManual.Models
{
    public class MCategory
    {
        [Key]
        public int InternalID { get; set; }
        public int MCategoryID { get; set; }
        public string MCategoryName { get; set; }
        public virtual ICollection<int> Medicines{ get; set;}
    }
}