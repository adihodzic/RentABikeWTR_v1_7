using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class DezurnaVozila
    {
        public int DezurnoVoziloId { get; set; }
        public string NazivDezurnogVozila { get; set; }
        public string TipVozila { get; set; } // Kombi vozilo ili Terenac (Džip) - zavisno od potrebe
    }
}
