using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class TuristickiVodiciUpsertRequest
    {

        public int TuristickiVodicId { get; set; }
        //public string KorisnickoIme { get; set; }
        //public string Lozinka { get; set; }
        public string Naziv { get; set; }
        public string Jezik { get; set; }
        public decimal CijenaVodica { get; set; }
    }
}
