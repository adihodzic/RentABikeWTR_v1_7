using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class NajaveOdmora
    {
        public int NajavaOdmoraId { get; set; }
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime DatumOdmora { get; set; }
        [DataType(DataType.Time)]
        [DisplayFormat(DataFormatString = "{0:hh/mm/ss}", ApplyFormatInEditMode = true)]
        public DateTime PocetakOdmora { get; set; }
        [DataType(DataType.Time)]
        [DisplayFormat(DataFormatString = "{0:hh/mm/ss}", ApplyFormatInEditMode = true)]
        public DateTime ZavrsetakOdmora { get; set; }
        public int NapitakKolicina { get; set; } = 0;
        public int LaunchPaketKolicina { get; set; } = 0;
    }
}
