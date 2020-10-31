using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace PrescriptionManual.Models
{
    public class MSubCategory
    {
        [Key]
        public int InternalID { get; set; }
        public int MSubCategoryID { get; set; }
        public string MSubCategoryName { get; set; }
        public virtual ICollection<int> Medicines { get; set; }
    }
}