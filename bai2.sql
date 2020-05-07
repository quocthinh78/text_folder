 -- 2A
 UPDATE khachhang SET dienthoai = '16267788989'
WHERE makhachhang='KH002';
-- 2B
UPDATE sanpham SET soluong = soluong +200
WHERE masanpham=3;
-- 2C
UPDATE sanpham SET dongia = dongia*(95/100);
-- 2D
UPDATE sanpham SET soluong =soluong + 100
WHERE masanpham IN (
SELECT sanpham.masanpham
FROM hoadon,hoadonchitiet,sanpham
WHERE hoadon.mahoadon= hoadonchitiet.mahoadon AND sanpham.masanpham= hoadonchitiet.masanpham AND MONTH(ngaymuahang)=12 AND YEAR(ngaymuahang)=2016
GROUP BY sanpham.masanpham
HAVING SUM(hoadonchitiet.soluong) >= ALL( SELECT  SUM(hoadonchitiet.soluong) FROM  hoadon, hoadonchitiet,sanpham 
WHERE hoadon.mahoadon= hoadonchitiet.mahoadon AND sanpham.masanpham= hoadonchitiet.masanpham AND MONTH(ngaymuahang)=12 AND YEAR(ngaymuahang)=2016
GROUP BY sanpham.masanpham));
-- 2E
UPDATE sanpham SET dongia = dongia*(90/100)
WHERE masanpham IN (
SELECT TOP 2 sanpham.masanpham
FROM hoadon, hoadonchitiet, sanpham
WHERE hoadon.mahoadon= hoadonchitiet.mahoadon AND sanpham.masanpham= hoadonchitiet.masanpham AND YEAR(ngaymuahang)=2016
GROUP BY sanpham.masanpham
ORDER BY SUM(hoadonchitiet.soluong) DESC );
-- 2F
UPDATE hoadon SET trangthai = 'Đã Thanh Toán'
WHERE mahoadon='10102';
-- 2G
DELETE
FROM hoadon
WHERE mahoadon='10101' AND trangthai='Chưa Thanh Toán';
-- 2H
FROM khachhang
DELETE 
WHERE makhachhang NOT IN (SELECT hoadon.makhachhang FROM khachhang, hoadon 
WHERE khachhang.makhachhang = hoadon.makhachhang AND DAY(ngaymuahang)>=1 AND MONTH(ngaymuahang)>=1 AND YEAR(ngaymuahang)>=2016);
select * from khachhang
