using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Korisnici
    {
        public Korisnici()
        {

            //RegistracijeVozila = new HashSet<RegistracijeVozila>();
            //Novosti = new HashSet<Novosti>();
        }
        public int KorisnikId { get; set; }
        public string KorisnickoIme { get; set; }
        public string LozinkaHash { get; set; }
        public string LozinkaSalt { get; set; }
        public bool Aktivan { get; set; } = true;
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Telefon { get; set; }
        //public string BrojLKPasosa { get; set; }
        public string Email { get; set; }


        public int? DrzavaID { get; set; }
        public virtual Drzave Drzava { get; set; }
        public DateTime DatumRegistracije { get; set; }
        public int UlogaID { get; set; }
        public virtual Uloge Uloga { get; set; }
        public virtual TuristickiVodici TuristickiVodic { get; set; } // ovo je 1:0 ili 1 veza
        public virtual Kupci Kupac { get; set; }
        public ICollection<Rezervacije> Rezervacije { get; set; }
        //public virtual ICollection<RegistracijeVozila> RegistracijeVozila { get; set; }
        //public virtual ICollection<Novosti> Novosti { get; set; }
    }
}
