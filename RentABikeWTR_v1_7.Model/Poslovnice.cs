using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class Poslovnice
    {
        public int PoslovnicaId { get; set; }
        public string NazivPoslovnice { get; set; }
        public string EmailKontakt { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }

        public ICollection<Bicikli> Bicikli { get; set; }
        public ICollection<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
    }
}
