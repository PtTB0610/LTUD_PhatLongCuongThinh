//THEM DU LIEU

//USER
EXEC SP_THEMDSUSER 'NV1', N'tuancuong','123456','admin','active'
EXEC SP_THEMDSUSER 'NV2', N'hoalong','123456','admin','active'
EXEC SP_THEMDSUSER 'NV3', N'tienphat', '123456','admin','active'
EXEC SP_THEMDSUSER 'NV4', N'vantu', '123456','employee','active'
EXEC SP_THEMDSUSER 'NV5', N'trunghieu', '123456','employee','active'
EXEC SP_THEMDSUSER 'NV6', N'trungkien', '123456','employee','inactive'
EXEC SP_THEMDSUSER 'NV7', N'tiensi', '123456','employee','inactive'
EXEC SP_THEMDSUSER 'NV8', N'nguyena', '123456','employee','active'
EXEC SP_THEMDSUSER 'NV9', N'nguyenb', '123456','employee','active'
EXEC SP_THEMDSUSER 'NV10', N'lehoang', '123456','employee','inactive'

//CUSTOMER
EXEC sp_addCUSTOMER 'KH1', N'Tuan Cuong', N'tcuong@gmail.com', '0902078366', '10/18/1999', N'Thu Duc'
EXEC sp_addCUSTOMER 'KH2', N'Hoa Long', N'vlong@gmail.com', '0902128321', '10/25/1997', N'Dong Nai'
EXEC sp_addCUSTOMER 'KH3', N'Tien Phat', N'tphat@gmail.com', '0122078366', '5/5/1995', N'Quan 9'
EXEC sp_addCUSTOMER 'KH4', N'Van Tu', N'tutdc@gmail.com', '0908070360', '6/6/1996', N'Trang Bom'
EXEC sp_addCUSTOMER 'KH5', N'Trung Hieu', N'hieu98@gmail.com', '0902111111', '10/20/1998', N'Da Nang'
EXEC sp_addCUSTOMER 'KH6', N'Trung Kien', N'kien777@gmail.com', '0902012344', '10/25/1996', N'Tay Ninh'
EXEC sp_addCUSTOMER 'KH7', N'Tien Si', N'sides1998@gmail.com', '0902121212', '10/11/1999', N'Tay Nguyen'
EXEC sp_addCUSTOMER 'KH8', N'Nguyen A', N'toilaai@gmail.com', '0902785421', '12/12/1990', N'Phu My'
EXEC sp_addCUSTOMER 'KH9', N'Nguyen B', N'aimabiet@gmail.com', '09020323232', '7/7/1997', N'Tay Ninh'
EXEC sp_addCUSTOMER 'KH10', N'Le Hoang', N'hoangbadboy@gmail.com', '0902995886', '10/20/1998', N'Dong Nai'

//EMPLOYEE
EXEC sp_ThemNhanVien 'NV1', N'Tuan Cuong', N'tcuong@gmail.com', '0902078366', '10/18/1999', N'Thu Duc'
EXEC sp_ThemNhanVien 'NV2', N'Hoa Long', N'vlong@gmail.com', '0902128321', '10/25/1997', N'Dong Nai'
EXEC sp_ThemNhanVien 'NV3', N'Tien Phat', N'tphat@gmail.com', '0122078366', '5/5/1995', N'Quan 9'
EXEC sp_ThemNhanVien 'NV4', N'Van Tu', N'tutdc@gmail.com', '0908070360', '6/6/1996', N'Trang Bom'
EXEC sp_ThemNhanVien 'NV5', N'Trung Hieu', N'hieu98@gmail.com', '0902111111', '10/20/1998', N'Da Nang'
EXEC sp_ThemNhanVien 'NV6', N'Trung Kien', N'kien777@gmail.com', '0902012344', '10/25/1996', N'Tay Ninh'
EXEC sp_ThemNhanVien 'NV7', N'Tien Si', N'sides1998@gmail.com', '0902121212', '10/11/1999', N'Tay Nguyen'
EXEC sp_ThemNhanVien 'NV8', N'Nguyen A', N'toilaai@gmail.com', '0902785421', '12/12/1990', N'Phu My'
EXEC sp_ThemNhanVien 'NV9', N'Nguyen B', N'aimabiet@gmail.com', '09020323232', '7/7/1997', N'Tay Ninh'
EXEC sp_ThemNhanVien 'NV10', N'Le Hoang', N'hoangbadboy@gmail.com', '0902995886', '10/20/1998', N'Dong Nai'