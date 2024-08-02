using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Servisiranja
    {
        public int ServisiranjeId { get; set; }
        public string OpisKvara { get; set; }
        public DateTime DatumServisiranja { get; set; }

        public string? PreduzetaAkcija { get; set; }
        public string? KomentarServisera { get; set; }
        public int? BiciklID { get; set; }
        public List<RezervniDijelovi>? RezervniDijelovi { get; set; }
    }
}
