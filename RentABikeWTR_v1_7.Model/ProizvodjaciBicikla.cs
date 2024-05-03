using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class ProizvodjaciBicikla
    {
        public int ProizvodjacBiciklaId { get; set; }
        public string NazivProizvodjaca { get; set; }

        public virtual ICollection<Bicikli> Bicikli { get; set; }
    }
}
