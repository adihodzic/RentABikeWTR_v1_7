using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoviBiciklaController : BaseCRUDController<Model.TipoviBicikla, TipoviBiciklaSearchRequest, TipoviBiciklaUpsertRequest, TipoviBiciklaUpsertRequest>
    {
        public TipoviBiciklaController(ICRUDService<Model.TipoviBicikla, TipoviBiciklaSearchRequest, TipoviBiciklaUpsertRequest, TipoviBiciklaUpsertRequest> service) : base(service)
        {
        }
    }
}
