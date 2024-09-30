using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KupciUpsertRequest
    {
        public int KupacId { get; set; }
        //[Required]
        //public string Ime { get; set; }
        //[Required]
        //public string Prezime { get; set; }
        //[Required]
        //[EmailAddress]
        //public string Email { get; set; }
        //[Required]
        //public string Telefon { get; set; }
        [Required]
        public string BrojLKPasosa { get; set; }
        //[Required]
        //public DateTime DatumRegistracije { get; set; }
        //public string Lozinka { get; set; }
        //public string PotvrdaLozinke { get; set; }

        //public bool Status { get; set; }

        //public int DrzavaID { get; set; }
        [Required]
        public string Grad { get; set; }
        [Required]
        public string Adresa { get; set; }
        public string Spol {  get; set; }
        public int? GodineKupacID {  get; set; }



    }
}
