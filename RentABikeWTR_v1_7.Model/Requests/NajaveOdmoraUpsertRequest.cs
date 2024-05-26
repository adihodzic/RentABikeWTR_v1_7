using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class NajaveOdmoraUpsertRequest
    {

        public DateTime DatumOdmora { get; set; }
        public DateTime PocetakOdmora { get; set; }
        public DateTime ZavrsetakOdmora { get; set; }
        public int NapitakKolicina { get; set; }
        public int LaunchPaketKolicina { get; set; }
        //public string LokacijaOdmora { get; set; }
        public int LokacijaOdmoraID { get; set; }
        public int? TuristickiVodicID { get; set; }
    }
}
