using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class TipoviBicikla
    {
        public int TipBiciklaId { get; set; }
        public string NazivTipa { get; set; }
        public ICollection<Bicikli> Bicikli { get; set; }
    }
}
