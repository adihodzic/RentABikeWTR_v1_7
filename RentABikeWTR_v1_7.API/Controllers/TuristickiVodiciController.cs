using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TuristickiVodiciController : BaseCRUDController<Model.TuristickiVodici, TuristickiVodiciSearchRequest, TuristickiVodiciUpsertRequest, TuristickiVodiciUpsertRequest>
    {
        public TuristickiVodiciController(ICRUDService<Model.TuristickiVodici, TuristickiVodiciSearchRequest, TuristickiVodiciUpsertRequest, TuristickiVodiciUpsertRequest> service) : base(service)
        {
        }
    }
}
