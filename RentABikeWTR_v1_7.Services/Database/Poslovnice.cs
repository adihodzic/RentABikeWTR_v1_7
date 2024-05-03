using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Poslovnice
    {
        public Poslovnice()
        {
            PoziviDezurnomVozilu = new HashSet<PoziviDezurnomVozilu>();
        }
        [Key]
        public int PoslovnicaId { get; set; }
        public string NazivPoslovnice { get; set; }
        public string EmailKontakt { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public ICollection<Bicikli> Bicikli { get; set; }
        public virtual ICollection<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
    }
}
