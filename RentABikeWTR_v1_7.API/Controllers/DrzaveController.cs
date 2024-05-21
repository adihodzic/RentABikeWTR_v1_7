using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DrzaveController : BaseCRUDController<Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest>
    {
        public DrzaveController(ICRUDService<Model.Drzave, DrzaveSearchRequest, DrzaveUpsertRequest, DrzaveUpsertRequest> service) : base(service)
        {
        }
    }
}
