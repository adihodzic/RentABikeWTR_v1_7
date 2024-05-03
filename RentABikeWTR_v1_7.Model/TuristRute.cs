using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class TuristRute
    {
        public int TuristRutaId { get; set; }
        public string Naziv { get; set; }
        public string OpisRute { get; set; }
        public decimal CijenaRute { get; set; }
        //public DateTime Termin { get; set; }
        public byte[]? SlikaRute { get; set; }
        //public int VrstaRuteID { get; set; } --- Grad ili Priroda
        //public int GrupaID { get; set; } -- Godine do 20, do 40, do 60

        public ICollection<Rezervacije> Rezervacije { get; set; }
    }
}
