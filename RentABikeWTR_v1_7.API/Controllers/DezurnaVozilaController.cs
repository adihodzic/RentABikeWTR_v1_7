using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DezurnaVozilaController : BaseCRUDController<Model.DezurnaVozila, DezurnaVozilaSearchRequest, DezurnaVozilaUpsertRequest, DezurnaVozilaUpsertRequest>
    {
        public DezurnaVozilaController(ICRUDService<Model.DezurnaVozila, DezurnaVozilaSearchRequest, DezurnaVozilaUpsertRequest, DezurnaVozilaUpsertRequest> service) : base(service)
        {
        }
    }
}
