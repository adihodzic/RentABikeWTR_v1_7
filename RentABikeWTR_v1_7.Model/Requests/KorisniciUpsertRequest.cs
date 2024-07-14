using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KorisniciUpsertRequest
    {


        //[Required(AllowEmptyStrings = false)]
        [Required]
        public string Ime { get; set; }
        [Required]
        public string Prezime { get; set; }
        [EmailAddress]
        [Required]
        public string Email { get; set; }
        [Required]

        public string Telefon { get; set; }
        [Required]
        public string KorisnickoIme { get; set; }

        [Required]
        public bool Aktivan { get; set; }
        //public List<int> Uloge { get; set; } = new List<int>();
        public int? DrzavaID { get; set; }
        //public string? NazivDrzave { get; set; }
        public int UlogaID { get; set; }

        [Required]
        public DateTime DatumRegistracije { get; set; }
        public string Password { get; set; }

        public string PasswordPotvrda { get; set; }


    }
}
