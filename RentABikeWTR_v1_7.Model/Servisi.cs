using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Servisi
    {
        public int ServisId { get; set; }
        public string OpisKvara { get; set; }
        public DateTime DatumServisa { get; set; }

        public string? PreduzetaAkcija { get; set; }
        public string? KomentarServisera { get; set; }
        public int? BiciklID { get; set; }
        public Bicikli Bicikl { get; set; }
        public ICollection<RezervniDijelovi> RezervniDijelovi { get; set; }
    }
}
