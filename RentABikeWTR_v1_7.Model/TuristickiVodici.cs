using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class TuristickiVodici
    {
        public int TuristickiVodicId { get; set; }
        // public string KorisnickoIme { get; set; }
        public string Naziv { get; set; }
        public string Jezik { get; set; }
        public decimal CijenaVodica { get; set; }
        //public ICollection<NajavaOdmora> NajavaOdmora { get; set; }
        //public ICollection<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
        //public ICollection<Rezervacije> Rezervacije { get; set; }
    }
}
