using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class RezervniDijelovi
    {
        public int RezervniDijeloviId { get; set; }
        public string NazivRezervnogDijela { get; set; }
        public string SerijskiBroj { get; set; }
        public bool NaStanju { get; set; }
        public int? ServisID { get; set; }
        public virtual Servisi Servis { get; set; }
        public int? KategorijaDijelovaID { get; set; }
        public KategorijeDijelova KategorijaDijelova { get; set; } = null;
    }
}
