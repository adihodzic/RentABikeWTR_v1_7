using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Rezervacije
    {
        public int RezervacijaId { get; set; }
        public DateTime DatumIzdavanja { get; set; }
        public DateTime VrijemePreuzimanja { get; set; }
        public DateTime VrijemeVracanja { get; set; }
        public string? Napomena { get; set; }
        public double CijenaUsluge { get; set; }
        public bool StatusPlacanja { get; set; }
        public int? KorisnikID { get; set; }
        //public virtual Korisnici Korisnik { get; set; }

        public int BiciklID { get; set; }
        //public Bicikli Bicikl { get; set; }

        //public bool SaTuristicikimVodicem { get; set; }
        public int? TuristickiVodicID { get; set; }
        //public virtual TuristickiVodici TuristickiVodic { get; set; }


        public int? TuristRutaID { get; set; }
        //public virtual TuristRute TuristRuta { get; set; }


        //public int RezervacijaId { get; set; }

        public int KupacID { get; set; }
        //public Kupci Kupac { get; set; }
    }
}
