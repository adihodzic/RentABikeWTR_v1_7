using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GenderiController : BaseController<Model.Genderi, object>
    {
        public GenderiController(IService<Model.Genderi, object> service) : base(service)
        {
        }
    }
}
