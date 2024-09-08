using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model
{
    public class RezervacijePregled
    {
        public int? RezervacijaId { get; set; }
        public int? BiciklID { get; set; }
        public int? KupacID { get; set; }
        public DateTime? DatumIzdavanja { get; set; }
        public string? NazivBicikla { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }

        //dodajem jos
        public int? TuristRutaID { get; set; }
        public string? NazivRute { get; set; }
        public int? TuristickiVodicID { get; set; }
        public string? NazivVodica { get; set; } //naziv turistickog vodica
        public double? CijenaUsluge { get; set; }

    }
}
