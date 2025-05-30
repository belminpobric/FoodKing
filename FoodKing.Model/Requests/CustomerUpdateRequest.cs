﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class CustomerUpdateRequest
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }
        
        public string PhoneNumber { get; set; }
        public string? Photo { get; set; }
        public string? Address { get; set; }
        public string? Username { get; set; }
        public string Email { get; set; }
        public DateTime updatedAt { get; set; } = DateTime.Now;
    }
}
