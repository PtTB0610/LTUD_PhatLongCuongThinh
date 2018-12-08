﻿using System;
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
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        string userType = clsFormProvider.loginF.getUserType();
        string userName;
        public string getUserType()
        {
            return userType;
        }

        public void setUserType(string userType)
        {
            this.userType = userType;
        }

        public string getUserName()
        {
            return this.userName;
        }

        public void setUserName(string userName)
        {
            this.userName = userName;
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show("Are you sure you want to exit?", "Exit Confirmation", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.No)
            {
                e.Cancel = true;
            }
        }

        private void mneLogout_Click(object sender, EventArgs e)
        {
            Application.Restart();
            //this.Hide();
            //clsFormProvider.loginF.ShowDialog();
            //lbUserType.Text = "";
            //lbUserType.Text = clsFormProvider.loginF.getUserType();
        }

        private void mnuAccountInfo_Click(object sender, EventArgs e)
        {
            UserInfoForm UIForm = new UserInfoForm();
            UIForm.MdiParent = this;
            UIForm.Show();
        }

        private void mnuExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        ProductForm productForm;
        private void mnuViewProduct_Click(object sender, EventArgs e)
        {
            if (productForm != null)
            {
                productForm.Show();
            }
            else
            {
                productForm = new ProductForm();
                productForm.MdiParent = this;
                productForm.Dock = DockStyle.Fill;
                productForm.Show();
                productForm.FormClosing += productForm_FormClosing;
            }
        }

        public void productForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            productForm = null;
        }

        private void mnuViewEmployee_Click(object sender, EventArgs e)
        {
            EmployeeFORM employeeform = new EmployeeFORM();
            employeeform.MdiParent = this;
            employeeform.TopLevel = false;
            employeeform.Dock = DockStyle.Fill;
            employeeform.Show();

        }
        //Chi cho phep tao 1 UserInfoForm
        UserInfoForm userInfoForm;
        private void userToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (userInfoForm != null)
            {
                userInfoForm.Show();
            }
            else
            {
                userInfoForm = new UserInfoForm();
                userInfoForm.MdiParent = clsFormProvider.mainF;
                userInfoForm.Show();
                userInfoForm.FormClosing += userInfoForm_FormClosing;
            }
        }
        public void userInfoForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            userInfoForm = null;
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            if (getUserType() == "User") {
                userToolStripMenuItem.Visible = false;
            }
        }
    }
}
