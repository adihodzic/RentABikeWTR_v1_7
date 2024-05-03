using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class ProizvodjaciBicikla
    {
        [Key]
        public int ProizvodjacBiciklaId { get; set; }
        public string NazivProizvodjaca { get; set; }

        public ICollection<Bicikli> Bicikli { get; set; }
    }
}
