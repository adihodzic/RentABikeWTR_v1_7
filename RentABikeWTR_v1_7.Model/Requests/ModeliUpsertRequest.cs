using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class ModeliUpsertRequest
    {
        [Required]
        public string NazivModela { get; set; }
        //public int? ProizvodjacBiciklaID { get; set; }
        public int ModelBiciklaId { get; set; }
        //public int? TipBiciklaID { get; set; }

        // public string NazivProizvodjaca { get; set; }
        //public string NazivTipa { get; set; }


    }
}
