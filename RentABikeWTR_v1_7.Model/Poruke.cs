using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Poruke
    {
        public int? PorukaId { get; set; }
        public string? Tekst { get; set; }
        public DateTime? DatumPoruke { get; set; }
        public int? KorisnikID { get; set; }

    }
}
