using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class PorukeUpsertRequest
    {

        public string? Tekst { get; set; }
        public DateTime? DatumPoruke { get; set; }
        public int? KorisnikID { get; set; }
        
    }
}
