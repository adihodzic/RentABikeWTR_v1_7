using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class PoziviDezurnomVozilu
    {
        public int? PozivDezurnomVoziluId { get; set; }
        public string? ViseDetalja { get; set; }
        public bool? Nesreca { get; set; }
        public bool? ZahtjevKlijenta { get; set; }
        public bool? Kvar { get; set; }
        public bool? LosiVremenskiUslovi { get; set; }

        public DateTime? DatumPoziva { get; set; }
        public DateTime? VrijemePoziva { get; set; }

        public int? DezurnoVoziloID { get; set; }
        public DezurnaVozila? DezurnoVozilo { get; set; }

        public int? TuristickiVodicID { get; set; }
        public virtual TuristickiVodici TuristickiVodic { get; set; }

        public int? PoslovnicaID { get; set; }

        public virtual Poslovnice Poslovnica { get; set; } = new Poslovnice();
    }
}
