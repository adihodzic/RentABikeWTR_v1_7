using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Statusi
    {
        public int StatusId { get; set; }
        public string NazivStatusa { get; set; }
        public ICollection<Bicikli> Bicikli { get; set; }

    }
}
