using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class ServisiranjaSearchRequest
    {

        public int? BiciklID { get; set; } //.... provjeriti jer dodaju se rezervni dijelovi za odredjeni bicikl
                                           // tako da se radi i servis za odredjeni bicikl...
                                           //public int ServisID { get; set; }
                                           //public string OpisKvara { get; set; }
                                           //public DateTime DatumServisa { get; set; }

        //public string PreduzetaAkcija { get; set; }
        //public string KomentarServisera { get; set; }
        //public List<string> RezervniDijeloviNazivi { get; set; }
        //public List<int> RezervniDijeloviIDs { get; set; }

    }
}
