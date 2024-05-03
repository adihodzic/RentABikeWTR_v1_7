using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class ModeliBicikla
    {
        public int ModelBiciklaId { get; set; }
        public string NazivModela { get; set; }

        //public int ProizvodjacBiciklaID { get; set; }
        //public ProizvodjaciBicikla ProizvodjacBicikla { get; set; }
        //public int TipBiciklaID { get; set; }
        //public virtual TipoviBicikla TipBicikla { get; set; }
        public virtual ICollection<Bicikli> Bicikli { get; set; }
    }
}
