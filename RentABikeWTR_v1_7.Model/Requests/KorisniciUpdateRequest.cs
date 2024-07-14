using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KorisniciUpdateRequest
    {
        //[Required(AllowEmptyStrings = false)]

        public int KorisnikId { get; set; }
        public string? Ime { get; set; }

        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        [EmailAddress]

        public string? Email { get; set; }

        public string? Telefon { get; set; }


        public bool? Aktivan { get; set; }
        public DateTime? DatumRegistracije { get; set; }
        public int? DrzavaID { get; set; }
        public int? UlogaID { get; set; }
        //public List<int> Uloge { get; set; } = new List<int>();









    }
}
