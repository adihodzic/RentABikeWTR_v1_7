using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Drzave
    {
        [Key]
        public int DrzavaID { get; set; }
        public string NazivDrzave { get; set; }
        public virtual ICollection<Bicikli> Bicikli { get; set; }
        public virtual ICollection<Korisnici> Korisnici { get; set; }
        //public virtual ICollection<Bicikli> Bicikli { get; set; }

        //public virtual ICollection<Kupci> Kupci { get; set; } -- ovo je vjerovatno bio problem
    }
}
