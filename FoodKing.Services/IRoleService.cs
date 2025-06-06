﻿using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IRoleService : ICRUDService<Model.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>
    {
    }
}
