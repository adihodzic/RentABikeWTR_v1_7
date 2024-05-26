using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PoslovniceController : BaseCRUDController<Model.Poslovnice, PoslovniceSearchRequest, PoslovniceUpsertRequest, PoslovniceUpsertRequest>
    {
        public PoslovniceController(ICRUDService<Model.Poslovnice, PoslovniceSearchRequest, PoslovniceUpsertRequest, PoslovniceUpsertRequest> service) : base(service)
        {
        }
    }
}
