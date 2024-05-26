using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KategorijeDijelovaController : BaseController<Model.KategorijeDijelova, object>
    {
        public KategorijeDijelovaController(IService<Model.KategorijeDijelova, object> service) : base(service)
        {
        }
    }
}
