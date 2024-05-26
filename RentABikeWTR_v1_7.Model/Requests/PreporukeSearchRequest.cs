using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class PreporukeSearchRequest
    {
        public string KorisnickoIme { get; set; }
        public int TipBiciklaId { get; set; }
        public int DatumIznajmljivanja { get; set; }
        public DateTime VrijemePreuzimanja { get; set; }
        public DateTime VrijemeVracanja { get; set; }

    }
}
