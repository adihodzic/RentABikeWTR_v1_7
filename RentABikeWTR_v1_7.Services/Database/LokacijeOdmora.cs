using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class LokacijeOdmora
    {
        public int LokacijaOdmoraId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public virtual ICollection<NajaveOdmora> NajavaOdmora { get; set; }
    }
}
