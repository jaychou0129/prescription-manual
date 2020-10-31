using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace PrescriptionManual.Models
{
    public class Medicine
    {
        [Key]
        public int InternalID { get; set; }
        public int MCategoryID { get; set; }
        public int MSubCategoryID { get; set; }
        public virtual MCategory MCategory { get; set; }
        public virtual MSubCategory MSubCategory { get; set; }

        [Required, Display(Name = "ID")]
        public int ID { get; set; }

        public string IDNote { get; set; }

        [Required, Display(Name = "Name")]
        public string Name { get; set; }
        public string Name2 { get; set; }

        [Required, StringLength(6)]
        public string DF_mID { get; set; }


        public string DF_subname { get; set; }
        public string DF_subname2 { get; set; }


        public string DF_dosage { get; set; }

        public string DF_form { get; set; }
        public string DF_note { get; set; }

        public string DosFormNote { get; set; }

        [Display(Name = "Usual Dose")]
        public string UsualDose { get; set; }

        [StringLength(2), Display(Name = "Category")]
        public string Category { get; set; }
        public string CategoryNote { get; set; }

        [Display(Name = "Note")]
        public string Note { get; set; }
        public string ImagePaths { get; set; }

    }
}