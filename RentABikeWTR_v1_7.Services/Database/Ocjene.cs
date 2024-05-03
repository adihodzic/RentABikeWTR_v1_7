using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Ocjene
    {
        public int OcjenaId { get; set; }
        public int Ocjena { get; set; }
        public DateTime DatumOcjene { get; set; }
        public int? BiciklID { get; set; }
        public virtual Bicikli Bicikl { get; set; }

        public int? KupacID { get; set; }
        public virtual Kupci Kupac { get; set; }
    }
}
