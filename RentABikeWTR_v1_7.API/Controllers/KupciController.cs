using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class KupciController : BaseCRUDController<Model.Kupci, KupciSearchRequest, KupciUpsertRequest, KupciUpsertRequest>
    {
        public KupciController(ICRUDService<Kupci, KupciSearchRequest, KupciUpsertRequest, KupciUpsertRequest> service) : base(service)
        {
        }

    }
}
