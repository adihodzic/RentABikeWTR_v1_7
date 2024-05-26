using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GodineKupciController : BaseController<Model.GodineKupci, object>
    {
        public GodineKupciController(IService<Model.GodineKupci, object> service) : base(service)
        {
        }
    }
}
