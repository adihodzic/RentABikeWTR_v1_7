using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Kupci
    {
        //public Kupci()
        //{
        //    Ocjene = new HashSet<Ocjene>();
        //    Rezervacije = new HashSet<Rezervacije>();
        //}
        [Key]
        [ForeignKey("Korisnici")]
        public int KupacId { get; set; }
        public string BrojLKPasosa { get; set; }
        public string Adresa { get; set; }
        public string Grad { get; set; }
        public string? Spol { get; set; }

        public virtual Korisnici Korisnik { get; set; }
        //public int? GenderID { get; set; }
        //public virtual Genderi Gender { get; set; }
        public int? GodineKupacID { get; set; }
        public virtual GodineKupci GodineKupac { get; set; }
        public virtual ICollection<Ocjene> Ocjene { get; set; }
        public virtual ICollection<Rezervacije> Rezervacije { get; set; }
    }
}
