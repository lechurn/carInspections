using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.errorType
{
    public class CreateUpdateInspectErrorType
    {
        public const string UNABLE_CREATE_UPDATE = "UNABLE_CREATE_UPDATE";
        public const string CREATE_UPDATE_SUCCESSFUL = "CREATE_UPDATE_SUCCESSFUL";
        public const string USER_BOOK_SAME_HOUR = "USER_BOOK_SAME_HOUR";
        public const string INVALID_DATE = "INVALID_DATE";
    }
}