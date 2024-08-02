using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class ServisiranjaUpsertRequest
    {

        public int ServisiranjeId { get; set; }
        public string? OpisKvara { get; set; }
        
        public DateTime? DatumServisiranja { get; set; }

        public string? PreduzetaAkcija { get; set; }
        public string? KomentarServisera { get; set; }

        public int? BiciklID { get; set; } //.... provjeriti jer dodaju se rezervni dijelovi za odredjeni bicikl
        // tako se i dodaje servis za odredjeni bicikl

        public List<RezervniDijelovi>? RezervniDijelovi { get; set; }
    }
}
