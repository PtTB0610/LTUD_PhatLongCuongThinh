﻿/*
Name: Le Nguyen Hoa Long
*/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ProjectC
{
    public partial class addEmployee : Form
    {
        public addEmployee()
        {
            InitializeComponent();
        }
        /// <summary>
        ///  Tao CSDL
        /// </summary>
        SqlConnection con = new SqlConnection("Data Source=.;Initial Catalog=ElectronicSupermarket;Integrated Security=True");
        clsDatabase db = new clsDatabase();
        /// <summary>
        /// Kiem Tra Phim Nhan Chi cho phep chu
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtEmpName_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !(char.IsLetter(e.KeyChar) || e.KeyChar == (char)Keys.Back || e.KeyChar == (char)Keys.Space);
        }
        /// <summary>
        /// Kiem Tra Phim Nhan Chi cho phep nhap so
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtEmpPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }
        /// <summary>
        /// Them Nhan Vien
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, EventArgs e)
        {
            con.Open();
            if (txtEmpID.Text != "" && txtEmpName.Text != "") // Neu Trong ID va User Yeu Cau nhap lai
            {
                try
                {
                    //Tao Co So du Lieu
                    SqlCommand cmd = new SqlCommand("sp_ThemNhanVien", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@employee_id", txtEmpID.Text));
                    cmd.Parameters.Add(new SqlParameter("@employee_name", txtEmpName.Text));
                    cmd.Parameters.Add(new SqlParameter("@employee_email", txtEmpEmail.Text));
                    cmd.Parameters.Add(new SqlParameter("@employee_phone", txtEmpPhone.Text));
                    cmd.Parameters.Add(new SqlParameter("@employee_date", dtBirth.Value));
                    cmd.Parameters.Add(new SqlParameter("@employee_address", txtEmpAdd.Text));

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Add Employee successful");
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("Add Employee unsuccessful");
                        
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Employee ID or Employee name is blank!!! Can not add new Employee!!!");
            }
            con.Close();
        }
    }
}

