using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class VelicineBicikla
    {
        public int VelicinaBiciklaId { get; set; }
        public string NazivVelicine { get; set; }
        public ICollection<Bicikli> Bicikli { get; set; }
    }
}
