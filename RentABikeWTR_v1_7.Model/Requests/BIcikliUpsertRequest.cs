using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class BicikliUpsertRequest
    {
        //public int BiciklId { get; set; }
        public string? NazivBicikla { get; set; }
        public string? Boja { get; set; }
        public decimal? NabavnaCijena { get; set; }

        public DateTime? GodinaProizvodnje { get; set; }
        public DateTime? DatumOtpisa { get; set; }
        public int? StatusID { get; set; }// statusi, ako je iznajmljen, otpisan, NaStanju
        //public string ZemljaPorijekla { get; set; }
        public DateTime? DatumZadnjegServisa { get; set; }
        public string? VrstaRama { get; set; }
        public byte[]? Slika { get; set; }

        public decimal? CijenaBicikla { get; set; }
        public string? NazivTipa { get; set; }
        public int? TipBiciklaId { get; set; }
        public string? NazivModela { get; set; }

        public int? ModelBiciklaID { get; set; }
        public string? NazivProizvodjaca { get; set; }
        public int? ProizvodjacBiciklaID { get; set; }
        public string? NazivVelicine { get; set; }

        public int? VelicinaBiciklaID { get; set; }
        public string? NazivPoslovnice { get; set; }
        public int? PoslovnicaID { get; set; }
        public string? NazivDrzave { get; set; }
        public int? DrzavaID { get; set; }





    }
}
