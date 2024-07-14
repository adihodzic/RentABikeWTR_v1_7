using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model
{
    public class BicikliDostupni
    {
        //public int? RezervacijaId { get; set; }
        public int? BiciklID { get; set; }
        public string? NazivBicikla { get; set; }
        public decimal? CijenaBicikla { get; set; }

        public string? Boja { get; set; }
        public byte[]? Slika { get; set; }
        
        public int? PoslovnicaID { get; set; }
        public string? NazivPoslovnice { get; set; }

        public int? ModelBiciklaID { get; set; }
        public string? NazivModela { get; set; }    
        public int? TipBiciklaID { get; set; }
        public string? NazivTipa { get; set; }
        public int? ProizvodjacBiciklaID { get; set; }
        public string? NazivProizvodjaca { get; set; }
        public int? DrzavaID { get; set; }
        public string? NazivDrzave { get; set; }




    }
}
