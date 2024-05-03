using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Genderi
    {
        [Key]
        public int GenderId { get; set; }
        public string NazivSpola { get; set; }

        public virtual ICollection<Kupci> Kupci { get; set; }
        //public virtual ICollection<Bicikli> Bicikli { get; set; }

        //public virtual ICollection<Kupci> Kupci { get; set; } -- ovo je vjerovatno bio problem
    }
}
