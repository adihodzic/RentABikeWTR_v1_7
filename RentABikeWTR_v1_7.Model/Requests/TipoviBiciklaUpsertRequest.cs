﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class TipoviBiciklaUpsertRequest
    {
        public int? TipId { get; set; }
        public string? NazivTipa { get; set; }
    }
}
