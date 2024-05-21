﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BicikliController : BaseCRUDController<Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest>
    {

        public BicikliController(ICRUDService<Model.Bicikli, BicikliSearchRequest, BicikliUpsertRequest, BicikliUpsertRequest> service) : base(service)
        {

        }

    }
}
