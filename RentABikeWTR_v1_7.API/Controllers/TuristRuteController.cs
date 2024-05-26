using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TuristRuteController : BaseCRUDController<Model.TuristRute, TuristRuteSearchRequest, TuristRuteUpsertRequest, TuristRuteUpsertRequest>
    {
        public TuristRuteController(ICRUDService<Model.TuristRute, TuristRuteSearchRequest, TuristRuteUpsertRequest, TuristRuteUpsertRequest> service) : base(service)
        {
        }
    }
}
