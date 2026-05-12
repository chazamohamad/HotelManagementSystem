using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using Oracle.ManagedDataAccess.Client;

namespace HotelManagementSystem.DAL
{
    public static class DBHelper
    {
        private const string ConnectionStringName = "OracleConn";

        public static OracleConnection GetConnection()
        {
            ConnectionStringSettings connectionSettings = ConfigurationManager.ConnectionStrings[ConnectionStringName];

            if (connectionSettings == null || string.IsNullOrWhiteSpace(connectionSettings.ConnectionString))
            {
                throw new ConfigurationErrorsException("Connection string 'OracleConn' was not found in Web.config.");
            }

            return new OracleConnection(connectionSettings.ConnectionString);
        }
    }
}
