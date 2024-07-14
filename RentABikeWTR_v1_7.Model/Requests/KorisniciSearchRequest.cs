using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KorisniciSearchRequest
    {

        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        //public string? Email { get; set; }

        //public string? Telefon { get; set; }

        public string? KorisnickoIme { get; set; }
        public int? UlogaID { get; set; }
        // public string? Password { get; set; }
        // public string? PasswordPotvrda { get; set; }

        //public bool? Status { get; set; }
        //public List<int> Uloge { get; set; } = new List<int>();
    }
}
