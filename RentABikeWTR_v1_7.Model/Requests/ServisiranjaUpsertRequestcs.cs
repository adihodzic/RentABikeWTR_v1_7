using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class ServisiranjaUpsertRequest
    {

        //public int ServisId { get; set; } .... imao sam error code 500 i vidio sam da u request-u stoji int ServisId=0; ...zato sam sada zakomentarisao
        public string OpisKvara { get; set; }
        public DateTime DatumServisa { get; set; }
        //public List<RezervniDijelovi> RezervniDijelovi { get; set; }
        public string PreduzetaAkcija { get; set; }
        public string KomentarServisera { get; set; }

        public int BiciklID { get; set; } //.... provjeriti jer dodaju se rezervni dijelovi za odredjeni bicikl
                                          // tako se i dodaje servis za odredjeni bicikl

        //public List<string> RezervniDijeloviNazivi { get; set; }
        public List<int> RezervniDijeloviIDs { get; set; }
    }
}
