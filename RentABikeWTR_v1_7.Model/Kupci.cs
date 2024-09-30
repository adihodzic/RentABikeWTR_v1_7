using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Kupci
    {
        //public Kupci()
        //{
        //    Ocjene = new HashSet<Ocjene>();
        //    Rezervacije = new HashSet<Rezervacije>();
        //}

        public int KupacId { get; set; }


        public string BrojLKPasosa { get; set; }
        public string Grad { get; set; }
        public string Adresa { get; set; }
        public string? Spol {  get; set; }
        //public int? GenderID { get; set; }
        public int? GodineKupacID { get; set; }



        //public virtual ICollection<Ocjene> Ocjene { get; set; }
        //public virtual ICollection<Rezervacije> Rezervacije { get; set; }
    }
}
