using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class TipoviBicikla
    {
        public int TipBiciklaId { get; set; }
        public string NazivTipa { get; set; }
        public ICollection<ModeliBicikla> ModeliBicikla { get; set; }
    }
}
