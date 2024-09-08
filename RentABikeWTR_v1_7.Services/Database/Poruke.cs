using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class Poruke
    {
        [Key]
        public int PorukaId { get; set; }
        public string? Tekst { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? DatumPoruke { get; set; }

        public int? KorisnikID { get; set; }
        public virtual Korisnici Korisnik { get; set; }
    }    
}
