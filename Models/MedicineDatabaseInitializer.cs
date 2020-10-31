using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Validation;

namespace PrescriptionManual.Models
{
    public class MedicineDatabaseInitializer : DropCreateDatabaseIfModelChanges<MedicineContext>
    {
        protected override void Seed(MedicineContext context)
        {

                GetMedicines().ForEach(m => context.Medicines.Add(m));
                GetMCategories().ForEach(c => context.MCategories.Add(c));
                GetMSubCategories().ForEach(s => context.MSubCategories.Add(s));

            
        }

        private static List<MCategory> GetMCategories()
        {
            var c = new List<MCategory> {
                new MCategory
                {
                    MCategoryID = 100,
                    MCategoryName = "0100. Antipyretics & Analgesics"
                },
                new MCategory
                {
                    MCategoryID = 200,
                    MCategoryName = "0200. Anticonvulsants, & Antiparkinsonian Drugs"
                }
            };
            return c;
        }
        private static List<MSubCategory> GetMSubCategories()
        {
            var s = new List<MSubCategory>
            {
                new MSubCategory
                {
                    MSubCategoryID = 110,
                    MSubCategoryName = "0110. Salicylates"
                },
                new MSubCategory
                {
                    MSubCategoryID = 120,
                    MSubCategoryName = "0120. Para-Aminophenol Derivatives"
                },
                new MSubCategory
                {
                    MSubCategoryID = 140,
                    MSubCategoryName = "0140. NSAIDs"
                },
                new MSubCategory
                {
                    MSubCategoryID = 210,
                    MSubCategoryName = "0210. Anticonvulsants, Antiepileptics"
                },
                new MSubCategory
                {
                    MSubCategoryID = 250,
                    MSubCategoryName = "0250. Antiparkinsonian Drugs"
                }
            };
            return s;
        }

        private static List<Medicine> GetMedicines()
        {
            var meds = new List<Medicine> {
                new Medicine
                {
                    MCategoryID = 100,
                    MSubCategoryID = 110,
                    ID = 111,
                    IDNote = "",
                    Name = "Epinephrine HCl",
                    Name2 = "",
                    DF_mID = "IADREN",
                    DF_subname = "Adrenaline",
                    DF_subname2 = "Bosmin",
                    DF_dosage = "1 mg/1 mL/amp",
                    DF_form = "Amp.",
                    DF_note = "",
                    DosFormNote = "",
                    UsualDose = "/Adults/ 0.2-0.5 mg repeated as needed, /Max/ 1 mg/dose;\n/Pediatric/ 0.01 mg/Kg, IM or SC.\nIV: 0.1 - 1 mg diluted in D5W 10 mL and given slowly.",
                    Category = "C",
                    CategoryNote = "",
                    Note = "",
                    ImagePaths = ""
                },
                new Medicine
                {
                    MCategoryID = 100,
                    MSubCategoryID = 120,
                    ID = 121,
                    IDNote = "",
                    Name = "Acetaminophen",
                    Name2 = "Panadol; ACT",
                    DF_mID = "OSCAN5\\OACTB",
                    DF_subname = "Scanol\\ACT",
                    DF_subname2 = "Paran\\Anti-phen",
                    DF_dosage = "500 mg/tab\\Syrup 24 mg/mL, 60mL/",
                    DF_form = "Tab.\\Btl.",
                    DF_note = "\\",
                    DosFormNote = "",
                    UsualDose = "/Adults/ (Scanol 500 mg) 1-2 tabs tid-qid, /Max/ 4 Gm/daily.\n/Pediatric/ (＜12 y/o): l0 - l5 mg / Kg q4 - 6 hrs as needed.",
                    Category = "B",
                    CategoryNote = "",
                    Note = "*ACT* Syrup含阿斯巴甜(Aspartame)賦形劑，苯酮尿症(PKU)患者不建議使用。",
                    ImagePaths = ""
                }
            };

            return meds;
        }
    }
}