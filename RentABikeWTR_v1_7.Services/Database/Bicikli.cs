using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Bicikli
    {
        // novi primjer[Key]
        public int BiciklId { get; set; }
        public string NazivBicikla { get; set; }
        public string Boja { get; set; }
        public decimal NabavnaCijena { get; set; }

        public DateTime GodinaProizvodnje { get; set; }
        public DateTime DatumOtpisa { get; set; }
        public decimal CijenaBicikla { get; set; } // ovo treba promijeniti


        public string VrstaRama { get; set; }

        public byte[]? Slika { get; set; }


        public int? VelicinaBiciklaID { get; set; }
        public virtual VelicineBicikla VelicinaBicikla { get; set; }
        public int? DrzavaID { get; set; }
        public virtual Drzave Drzava { get; set; }
        public int? StatusID { get; set; }// statusi, ako je iznajmljen, otpisan, NaStanju
        //Slobodan, Zauzet, Otpisan, Servis
        public virtual Statusi Status { get; set; }
        public int? PoslovnicaID { get; set; }
        public virtual Poslovnice Poslovnica { get; set; }

        public int? ProizvodjacBiciklaID { get; set; }
        public virtual ProizvodjaciBicikla ProizvodjacBicikla { get; set; }
        public int? TipBiciklaID { get; set; }
        public virtual TipoviBicikla TipBicikla { get; set; }
        public int? ModelBiciklaID { get; set; }
        public virtual ModeliBicikla ModelBicikla { get; set; }
        public virtual ICollection<Ocjene> Ocjene { get; set; }
        public virtual ICollection<Rezervacije> Rezervacije { get; set; }
        public virtual ICollection<Servisiranja> Servisiranje { get; set; }
    }
}
