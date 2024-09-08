using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Linq;
namespace RentABikeWTR_v1_7.Model
{
    public class BicikliPregled
    {
       
        public int BiciklID { get; set; }
        public string NazivBicikla { get; set; }
        public string Boja { get; set; }

        public decimal NabavnaCijena { get; set; }


        public DateTime GodinaProizvodnje { get; set; }
        public DateTime DatumOtpisa { get; set; }
        public decimal CijenaBicikla { get; set; }


        public DateTime DatumZadnjegServisa { get; set; }
        public string VrstaRama { get; set; }

        public byte[]? Slika { get; set; }
        public string? NazivModela { get; set; }
        public string? NazivTipa { get; set; }


        public int? VelicinaBiciklaID { get; set; }

        public int? StatusID { get; set; }// statusi, ako je na servisu, otpisan, NaStanju

        public int? PoslovnicaID { get; set; }

        public int? ModelBiciklaID { get; set; }
        public int? TipBiciklaID { get; set; }
        public int? ProizvodjacBiciklaID { get; set; }
        public int? DrzavaID { get; set; }
    }
}
