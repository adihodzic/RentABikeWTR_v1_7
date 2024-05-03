﻿using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Linq;
namespace RentABikeWTR_v1_7.Model
{
    public class Bicikli
    {
        [Key]
        public int BiciklId { get; set; }
        public string NazivBicikla { get; set; }
        public string Boja { get; set; }

        public decimal NabavnaCijena { get; set; }


        public DateTime GodinaProizvodnje { get; set; }
        public DateTime DatumOtpisa { get; set; }
        public decimal CijenaBicikla { get; set; }


        public DateTime DatumZadnjegServisa { get; set; }
        public string VrstaRama { get; set; }

        public byte[]? Slika { get; set; }


        public int? VelicinaBiciklaID { get; set; }

        public int? StatusID { get; set; }// statusi, ako je iznajmljen, otpisan, NaStanju

        public int? PoslovnicaID { get; set; }

        public int? ModelBiciklaID { get; set; }
        public int? TipBiciklaID { get; set; }
        public int? ProizvodjacBiciklaID { get; set; }
        public int? DrzavaID { get; set; }
    }
}
