using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class TuristRuteUpsertRequest
    {

        public string Naziv { get; set; }
        public string OpisRute { get; set; }
        public decimal CijenaRute { get; set; }
        //public DateTime Termin { get; set; }
        public byte[] Slika { get; set; }
        //public DateTime Termin { get; set; }
        //public int VrstaRuteID { get; set; } --- Grad ili Priroda
        //public int GrupaID { get; set; } -- Godine do 20, do 40, do 60
    }
}
