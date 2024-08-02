using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class RezervniDijeloviUpsertRequest
    {
        public int RezervniDijeloviId { get; set; }
        //public string? NazivRezervnogDijela { get; set; }
        //public string? SifraArtikla { get; set; }
        public int? NaStanju { get; set; }
        //public int? KategorijaDijelovaId { get; set; }
        

    }
}
