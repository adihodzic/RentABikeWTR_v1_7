using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LokacijeOdmoraController : BaseController<Model.LokacijeOdmora, object>
    {
        public LokacijeOdmoraController(IService<LokacijeOdmora, object> service) : base(service)
        {
        }
    }
}
