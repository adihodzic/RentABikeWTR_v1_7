using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class TuristRuteSearchRequest
    {
        public int? TuristRutaID { get; set; }

        public string? Naziv { get; set; }
        public string? OpisRute { get; set; }
        public decimal? CijenaRute { get; set; }
        //public DateTime Termin { get; set; }

    }
}
