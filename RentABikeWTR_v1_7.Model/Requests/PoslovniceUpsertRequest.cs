using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class PoslovniceUpsertRequest
    {

        public string NazivPoslovnice { get; set; }
        public string EmailKontakt { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }

    }
}
