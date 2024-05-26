using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UlogeController : BaseController<Model.Uloge, object>
    {
        public UlogeController(IService<Model.Uloge, object> service) : base(service)
        {
        }
    }
}
