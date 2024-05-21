using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class KupciSearchRequest
    {

        public int? KupacId { get; set; }
        public string? BrojLKPasosa { get; set; }
        public string? Adresa { get; set; }
        public string? Grad { get; set; }

    }
}
