using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoviBiciklaController : BaseController<Model.TipoviBicikla, object>
    {
        public TipoviBiciklaController(IService<Model.TipoviBicikla, object> service) : base(service)
        {
        }
    }
}
