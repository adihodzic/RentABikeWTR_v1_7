using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class KategorijeDijelova
    {
        public int KategorijaDijelovaId { get; set; }
        public string NazivKategorije { get; set; }
        public ICollection<RezervniDijelovi> RezervniDijelovi { get; set; }
    }
}
