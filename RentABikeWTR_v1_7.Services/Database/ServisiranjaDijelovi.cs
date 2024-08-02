using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class ServisiranjaDijelovi
    {
        public int ServisiranjaDijeloviId { get; set; }
        public int? RezervniDijeloviID { get; set; }
        public virtual RezervniDijelovi RezervniDio { get; set; }
        public int? ServisiranjeID { get; set; }
        public virtual Servisiranja Servisiranje { get; set; }
    }
}
