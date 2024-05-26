using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VelicineBiciklaController : BaseController<Model.VelicineBicikla, object>
    {
        public VelicineBiciklaController(IService<Model.VelicineBicikla, object> service) : base(service)
        {
        }
    }
}
