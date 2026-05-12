using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace HotelManagementSystem.DAL
{
    public class UserRepository
    {
        public bool SignInUser(string username, string password)
        {
            using (var conn = DBHelper.GetConnection())
            {
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "BEGIN :result := SIGN_IN_USER(:username, :password); END;";
                    cmd.CommandType = CommandType.Text;

                    var resultParam = new OracleParameter("result", OracleDbType.Decimal)
                    {
                        Direction = ParameterDirection.Output
                    };

                    cmd.Parameters.Add(resultParam);
                    cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = username;
                    cmd.Parameters.Add("password", OracleDbType.Varchar2).Value = password;

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    int result = Convert.ToInt32(resultParam.Value.ToString());

                    return result == 1;
                }
            }
        }
    }
}