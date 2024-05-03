using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Servisiranja
    {
        public int ServisiranjeId { get; set; }
        public string OpisKvara { get; set; }
        public DateTime DatumServisiranja { get; set; }
        public string? PreduzetaAkcija { get; set; }
        public string? KomentarServisera { get; set; }
        public int? BiciklID { get; set; }
        public Bicikli Bicikl { get; set; }
        public ICollection<RezervniDijelovi> RezervniDijelovi { get; set; }

    }
}
