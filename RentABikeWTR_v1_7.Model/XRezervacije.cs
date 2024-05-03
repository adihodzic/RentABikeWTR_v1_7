using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class XRezervacije
    {
        public int RezervacijaId { get; set; }

        //public DateTime DatumOd { get; set; }
        //public DateTime DatumDo { get; set; }
        public DateTime Datum { get; set; }
        public decimal CijenaUsluge { get; set; }
        public int KupacId { get; set; }
    }
}
