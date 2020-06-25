using carInspections.Properties;
using System;
using System.Data;
using System.Data.SqlClient;

namespace carInspections
{
    public class carFELib
    {
        string DB_Conn = Settings.Default.DB_Conn;

        public int registerAccount(string username, string password)
        {
            int customerId = -1;
            using (SqlConnection connection = new SqlConnection(DB_Conn))
            {

                try
                {
                    SqlParameter newUserId = new SqlParameter("@newUserId", SqlDbType.Int);
                    newUserId.Direction = ParameterDirection.Output;

                    connection.Open();
                    SqlCommand command = new SqlCommand("usp_insert_User", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                    command.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                    command.Parameters.Add(newUserId);
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandTimeout = 5;

                    command.ExecuteNonQuery();

                    if (int.Parse(newUserId.Value.ToString()) !=0 ) {
                        customerId = int.Parse(newUserId.Value.ToString());
                    }
                }
                catch (Exception ex)
                {
                    /*Handle error*/
                }
            }

            return customerId;
        }


        public userValidateReponse validateUser(string username, string password)
        {
            userValidateReponse userValidResponse = new userValidateReponse();
            userValidResponse.isValidUser = false;

            userModel userModel = getUser(username);

            if (userModel.userId != 0)
            {
                bool isValidPassword = BCrypt.Net.BCrypt.Verify(password, userModel.password);
                if (isValidPassword)
                {
                    userValidResponse.isValidUser = true;
                    userValidResponse.userId = userModel.userId;
                }
            }

            return userValidResponse;
        }

        private userModel getUser(string username)
        {
            userModel userModel = new userModel();
            DataSet dataSet = new DataSet();
            using (SqlConnection connection = new SqlConnection(DB_Conn))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT id,userName,password from [User] WHERE userName = @username", connection);
                    command.CommandType = System.Data.CommandType.Text;
                    command.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                    command.CommandTimeout = 5;

                    dataSet.Tables.Clear();
                    var da = new SqlDataAdapter(command);
                    da.Fill(dataSet, "User");

                    if (dataSet.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow row in dataSet.Tables[0].Rows)
                        {
                            userModel.userId = int.Parse(row[0].ToString());
                            userModel.username = row[1].ToString();
                            userModel.password = row[2].ToString();
                        }
                    }                   
                }
                catch (Exception ex)
                {
                    /*Handle error*/
                }
            }

            return userModel;
        }
    }
}