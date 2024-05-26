using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ModeliBiciklaController : BaseCRUDController<Model.ModeliBicikla, ModeliSearchRequest, ModeliUpsertRequest, ModeliUpsertRequest>
    {
        public ModeliBiciklaController(ICRUDService<ModeliBicikla, ModeliSearchRequest, ModeliUpsertRequest, ModeliUpsertRequest> service) : base(service)
        {
        }
    }
}
