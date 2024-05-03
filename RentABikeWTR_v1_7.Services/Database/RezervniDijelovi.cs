﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services.Database
{
    public class RezervniDijelovi
    {
        public int RezervniDijeloviId { get; set; }
        public string NazivRezervnogDijela { get; set; }
        public string SerijskiBroj { get; set; }
        public bool NaStanju { get; set; }
        public int? KategorijaDijelovaID { get; set; }
        public virtual KategorijeDijelova KategorijaDijelova { get; set; }
        public int? ServisiranjeID { get; set; }
        public virtual Servisiranja Servisiranje { get; set; }
    }
}
