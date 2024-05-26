using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StatusiController : BaseController<Model.Statusi, object>
    {
        public StatusiController(IService<Model.Statusi, object> service) : base(service)
        {
        }
    }
}
