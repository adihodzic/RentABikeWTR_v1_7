using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class ModeliBicikla
    {
        public int? ModelBiciklaId { get; set; }
        public string? NazivModela { get; set; }
        
        public ICollection<Bicikli> Bicikli { get; set; }
    }
}
