using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class GodineKupci
    {
        public int GodineKupacId { get; set; }
        public string GodinePoGrupama { get; set; }
        public virtual ICollection<Kupci> Kupci { get; set; }
    }
}
