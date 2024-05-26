using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class RezervacijeUpsertRequest
    {

        //public int RezervacijaId { get; set; }
        public DateTime DatumIzdavanja { get; set; }
        public DateTime VrijemePreuzimanja { get; set; }
        public DateTime VrijemeVracanja { get; set; }
        public string? Napomena { get; set; }
        public decimal CijenaUsluge { get; set; }
        public bool StatusPlacanja { get; set; }
        public int? KorisnikID { get; set; }
        public string? KorisnickoImeKorisnik { get; set; }
        public int KupacID { get; set; }
        public string? KorisnickoImeKupac { get; set; }

        public int BiciklID { get; set; }
        //public int? ModelBiciklaID { get; set; }
        //public string NazivModela { get; set; }
        public int? PoslovnicaID { get; set; }
        public string? NazivPoslovnice { get; set; }
        public int? TuristickiVodicID { get; set; }

        public string? NazivTurstickogVodica { get; set; }
        public int? TuristRutaID { get; set; }
        public string? NazivRute { get; set; }

    }
}
