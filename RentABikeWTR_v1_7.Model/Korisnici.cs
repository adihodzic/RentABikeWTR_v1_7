using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Korisnici
    {
        //public Korisnici()
        //{
        //    KorisniciUloge = new HashSet<KorisniciUloge>();
        //    //RegistracijeVozila = new HashSet<RegistracijeVozila>();
        //    //Novosti = new HashSet<Novosti>();
        //}
        public int KorisnikId { get; set; }
        public string KorisnickoIme { get; set; }
        public string Password { get; set; }

        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }

        public DateTime DatumRegistracije { get; set; }
        public bool Aktivan { get; set; } = true;
        public int UlogaID { get; set; }
        public Uloge Uloga { get; set; }
        public int DrzavaID { get; set; }

        public Drzave Drzava { get; set; }

        //public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; }
        //public virtual ICollection<RegistracijeVozila> RegistracijeVozila { get; set; }
        //public virtual ICollection<Novosti> Novosti { get; set; }
    }
}
