using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class DezurnaVozila
    {
        public DezurnaVozila()
        {

            PoziviDezurnomVozilu = new HashSet<PoziviDezurnomVozilu>();
        }


        // ovo mora biti isto kao što je na DateSet-u ....
        //Dakle, ako je tamo PoziviDezurnomVozilus ...
        // onda i ovjde mora biti na kraju slovo s, kao i u propertiju virtual ICollection dole na dnu
        [Key]
        public int DezurnoVoziloId { get; set; }
        public string NazivDezurnogVozila { get; set; }
        public string TipVozila { get; set; } // Kombi vozilo ili Terenac (Džip) - zavisno od potrebe
        public virtual ICollection<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
    }
}
