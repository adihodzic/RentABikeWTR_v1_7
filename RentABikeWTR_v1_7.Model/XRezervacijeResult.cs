using System;
using System.Collections.Generic;
using System.Text;

namespace RentABikeWTR_v1_7.Model
{
    public class XRezervacijeResult
    {
        public decimal? UkupnaSuma { get; set; }
        public List<Model.XRezervacije>? XRezervacijeLista { get; set; }

    }
}
