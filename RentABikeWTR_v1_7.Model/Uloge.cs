using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Uloge
    {
        //public Uloge()
        //{
        //    KorisniciUloge = new HashSet<KorisniciUloge>();
        //}
        public int UlogaId { get; set; }
        public string NazivUloge { get; set; }
        public string OpisUloge { get; set; }
        public virtual ICollection<Korisnici> Korisnici { get; set; }
    }
}
