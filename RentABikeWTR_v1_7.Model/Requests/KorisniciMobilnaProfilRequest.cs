using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KorisniciMobilnaProfilRequest
    {


        //[Required(AllowEmptyStrings = false)]

        public int? KorisnikId { get; set; }

        public string? Ime { get; set; }

        public string? Prezime { get; set; }
        [EmailAddress]

        public string? Email { get; set; }


        public string? Telefon { get; set; }

        public string? KorisnickoIme { get; set; }


        public bool? Aktivan { get; set; } = true;
        //public List<int> Uloge { get; set; } = new List<int>();
        public int? DrzavaID { get; set; }
        //public string? NazivDrzave { get; set; }
        public int UlogaID { get; set; } = 4;


        //public DateTime DatumRegistracije { get; set; }
        public string? Password { get; set; }

        public string? PasswordPotvrda { get; set; }


    }
}
