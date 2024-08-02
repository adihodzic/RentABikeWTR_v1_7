using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class RezervniDijeloviPregled
    {
        public int? RezervniDijeloviId { get; set; }
        public string? NazivRezervnogDijela { get; set; }
        public string? SifraArtikla { get; set; }
        public int? NaStanju { get; set; }
       
        public string? NazivKategorije { get; set; }
        
    }
}
