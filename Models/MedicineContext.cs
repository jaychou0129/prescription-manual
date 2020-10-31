using System.Data.Entity;

namespace PrescriptionManual.Models
{
    public class MedicineContext : DbContext
    {
        public MedicineContext() : base("PrescriptionManual")
        {
        }
        public DbSet<MSubCategory> MSubCategories { get; set; }
        public DbSet<MCategory> MCategories { get; set; }
        public DbSet<Medicine> Medicines { get; set; }

    }
}