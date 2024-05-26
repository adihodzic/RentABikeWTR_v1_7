using Microsoft.EntityFrameworkCore.Storage;
using RentABikeWTR_v1_7.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Model.Requests
{
    public class GenderiSearchRequest
    {
        //public int DrzavaID { get; set; }
        public string? NazivSpola { get; set; }
    }
}
