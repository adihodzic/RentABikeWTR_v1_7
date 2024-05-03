using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class LokacijeOdmora
    {
        public int LokacijaOdmoraId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public ICollection<NajavaOdmora> NajavaOdmora { get; set; }
    }
}
