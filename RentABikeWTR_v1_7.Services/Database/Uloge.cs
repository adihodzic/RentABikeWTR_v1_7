using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Uloge
    {
        public int UlogaId { get; set; }
        public string NazivUloge { get; set; }
        public string OpisUloge { get; set; }
        public virtual ICollection<Korisnici> Korisnici { get; set; }
    }
}
