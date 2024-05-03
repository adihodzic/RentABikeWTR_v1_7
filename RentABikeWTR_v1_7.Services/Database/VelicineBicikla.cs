using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class VelicineBicikla
    {
        public int VelicinaBiciklaId { get; set; }
        public string NazivVelicine { get; set; }
        public ICollection<Bicikli> Bicikli { get; set; }
    }
}
