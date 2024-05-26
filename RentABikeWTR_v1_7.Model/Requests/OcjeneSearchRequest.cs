using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class OcjeneSearchRequest
    {

        public int? Ocjena { get; set; }
        public DateTime? DatumOcjene { get; set; }
        public int? BiciklID { get; set; }
        public int? KupacID { get; set; }
    }
}
