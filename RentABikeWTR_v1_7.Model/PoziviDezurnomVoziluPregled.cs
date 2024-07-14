using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model
{
    public class PoziviDezurnomVoziluPregled
    {
        
        public int? PozivDezurnomVoziluId { get; set; }
        public String? ViseDetalja { get; set; }
        public bool? Nesreca { get; set; }
        public bool? ZahtjevKlijenta { get; set; }
        public bool? Kvar { get; set; }
        public bool? LosiVremenskiUslovi { get; set; }
        public DateTime? DatumPoziva { get; set; }
        public DateTime? VrijemePoziva { get; set; }
        public int? DezurnoVoziloID { get; set; }
        public String? NazivDezurnogVozila { get; set; }
        public int? TuristickiVodicID { get; set; }
        public String? Naziv { get; set; } // Naziv turistickog vodica
        public int? PoslovnicaID { get; set; }
        public String? NazivPoslovnice { get; set; }
    }
}
