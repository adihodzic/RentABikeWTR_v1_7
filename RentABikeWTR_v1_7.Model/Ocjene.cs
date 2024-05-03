using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Ocjene
    {
        public int OcjenaId { get; set; }
        public int Ocjena { get; set; }
        public DateTime DatumOcjene { get; set; }
        public int BiciklID { get; set; }
        //public Bicikli Bicikl { get; set; }

        public int KupacID { get; set; }
        //public Kupci Kupac { get; set; }
    }
}
