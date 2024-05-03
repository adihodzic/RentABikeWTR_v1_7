using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class TuristickiVodici
    {
        [Key]
        [ForeignKey("Korisnici")]
        public int TuristickiVodicId { get; set; }
        //public string KorisnickoIme { get; set; }
        //public string LozinkaHash { get; set; }
        //public string LozinkaSalt { get; set; }
        public string Naziv { get; set; }
        public string Jezik { get; set; }
        public decimal CijenaVodica { get; set; }
        public virtual Korisnici Korisnik { get; set; }
        public ICollection<NajaveOdmora> NajavaOdmora { get; set; }
        public ICollection<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
        public ICollection<Rezervacije> Rezervacije { get; set; }
    }
}
