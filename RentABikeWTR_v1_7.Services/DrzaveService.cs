﻿using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class DrzaveService : BaseCRUDService<Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest, Database.Drzave>
    {
        public DrzaveService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
