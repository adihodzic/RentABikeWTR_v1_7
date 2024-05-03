using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class PoziviDezurnomVozilu
    {
        public int PozivDezurnomVoziluId { get; set; }
        public string? ViseDetalja { get; set; }
        public bool Nesreca { get; set; }
        public bool ZahtjevKlijenta { get; set; }
        public bool Kvar { get; set; }
        public bool LosiVremenskiUslovi { get; set; }
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime DatumPoziva { get; set; }
        [DataType(DataType.Time)]
        [DisplayFormat(DataFormatString = "{0:hh/mm/ss}", ApplyFormatInEditMode = true)]
        public DateTime VrijemePoziva { get; set; }

        public int? DezurnoVoziloID { get; set; }
        public virtual DezurnaVozila DezurnoVozilo { get; set; }
        public int? TuristickiVodicID { get; set; }
        public virtual TuristickiVodici TuristickiVodic { get; set; }
        public int? PoslovnicaID { get; set; }
        public virtual Poslovnice Poslovnica { get; set; }
    }
}
