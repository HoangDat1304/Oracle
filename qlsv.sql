/* I. CREATE TABLES */

-- faculty (Khoa trong tr??ng)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn h?c)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- gi?i tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- h?c b?ng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (B?ng ?i?m)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- s? l?n thi (thi trên 1 l?n ???c g?i là thi l?i) 
	mark number(4,2) not null -- ?i?m
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, 'C? s? d? li?u', 45);
insert into subject values (2, 'Trí tu? nhân t?o', 45);
insert into subject values (3, 'Truy?n tin', 45);
insert into subject values (4, '?? h?a', 60);
insert into subject values (5, 'V?n ph?m', 45);


-- faculty
insert into faculty values (1, 'Anh - V?n');
insert into faculty values (2, 'Tin h?c');
insert into faculty values (3, 'Tri?t h?c');
insert into faculty values (4, 'V?t lý');


-- student
insert into student values (1, 'Nguy?n Th? H?i', 'N?', to_date('19900223', 'YYYYMMDD'), 'Hà N?i', 130000, 2);
insert into student values (2, 'Tr?n V?n Chính', 'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình ??nh', 150000, 4);
insert into student values (3, 'Lê Thu Y?n', 'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, 'Lê Thu Y?n', 'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, 'Tr?n Anh Tu?n', 'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà N?i', 180000, 1);
insert into student values (6, 'Tr?n Thanh Mai', 'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Phòng', null, 3);
insert into student values (7, 'Tr?n Th? Thu Th?y', 'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
--      b. gi?i tính
--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
Select * from student order by student.id asc;
Select * from student order by student.gender desc;
Select * from student order by student.birthday asc , student.scholarship desc;


-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
Select subject.name from subject where NAME like 'T%';

-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
Select student.name from student where name like '%i';

-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
Select faculty.name from faculty where name like '_%n';

-- 5. Sinh viên trong tên có t? 'Th?'
Select student.name from student where name like '%Th?%';

-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
Select student.name from student where name between 'A' and 'M' group by student.name;

-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
Select student.scholarship from student where scholarship >100000  order by student.faculty_id desc ;

-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
Select student.scholarship from student where scholarship >15000 and student.hometown like N'Hà N?i';

-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
Select student.birthday from student where birthday between to_date('01/01/1991','DD/MM/YYYY') and to_date('05/06/1992','DD/MM/YYYY');

-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
Select student.scholarship from student where scholarship between '8000' and '1500000';
-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
Select subject.name from subject where lesson_quantity between '30' and '45';



-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
Select student1.id ,gender,faculty.id ,scholarship ,
case 
	when scholarship >500000 
	then N'h?c b?ng'
	else N'm?c trung bình'
end 
from student student1 inner join faculty on student1.faculty_id = faculty.id;

		
-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
Select COUNT(id) as sinhvien from student;

-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
Select gender , COUNT(id) from student group by gender;


-- 4. Tính t?ng s? sinh viên t?ng khoa (ch?a c?n JOIN)
Select faculty_id , COUNT(*) from student group by faculty_id;

-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
Select subject.name, count(exam_management.student_id) from exam_management, subject
where subject.id = exam_management.subject_id 
group by subject.name;

-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
Select student.id , count(subject_id) from exam_management group by  student_id;

-- 7. T?ng s? h?c b?ng c?a m?i khoa	
Select faculty.name, count(student.scholarship) from faculty, student
where faculty.id = student.faculty_id 
group by faculty.name;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty.name, max(student.scholarship) from faculty, student
where faculty.id = student.faculty_id 
group by faculty.name;

-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa


-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
Select  student.birthday count(student_id) from student
group by student.birthday;
-- 11. Cho bi?t nh?ng n?i nào có h?n 2 sinh viên ?ang theo h?c t?i tr??ng
Select student.hometown , count(student_id) * from student
group by student.hometown
having count(student_id) >2;
-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
Select student.name , exam_management.subject_id , count(thilai) from student
where student.id = exam_management.student_id
group by student.name , exam_management.subject_id
having count(thilai) >2;

-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0 
Select student.name , avg(exam_management.mark) from student , exam_management
where student.id = exam_management.student_id and student.gender = N'Nam' and  exam_management.number_of_exam_taking =1 
group by student.name
having avg(exam_management.mark) >7;
-- 14. Cho bi?t danh sách các sinh viên r?t trên 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)

Select student.name from student , exam_management
where exam_management.number_of_exam_taking = 1 and exam_management.mark < 4 and student.id = exam_management.student_id 
group by student.name;
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam (ch?a c?n JOIN)
Select faculty.name , count(student.gender) from student , faculty
where  faculty.id = student.faculty_id and student.gender = N'Nam'
group by faculty.name
having count(student.gender) >2;

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
Select  faculty.name ,count(student.id)  from faculty , student
where student.scholarship >= 200000 anh student.scholarship =<300000
group by faculty.name 
having count(student.id) = 2;
-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t

Select student.name  , max(student.scholarship) from student
where student.scholarship = (select max(student.scholarship)) from student
group by student.name;;



-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
Select student.name  from student
where student.hometown = N'HÀ N?I' and to_char(birthday,'MM') = 02;
-- 2. Sinh viên có tu?i l?n h?n 20

-- 3. Sinh viên sinh vào mùa xuân n?m 1990
select student.name
from student
where to_char(student.birthday, 'YYYY') = '1990' and to_char(student.birthday, 'MM') in ('01', '02', '03');


-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
Select student.name  from student join faculty on faculty.id = student.faculty_id
where faculty.name ='anh v?n' and faculty.name ='v?t lý'

-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select student.name, faculty.name from student ,faculty
where   faculty.id = student.faculty_id  and (faculty.name = 'Anh - V?n' or faculty.name = 'Tin h?c') and student.gender = N'Nam';

-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t

-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.


-- 5. Cho bi?t khoa nào có ?ông sinh viên nh?t

-- 6. Cho bi?t khoa nào có ?ông n? nh?t

-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn
select student.name , max(mark) from  student , exam_management
where  exam_management.student_id = student.id
group by student.name;

-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
Select faculty.name, count(student.id) from faculty join student on  student.faculty_id = faculty.id
group by faculty.name
having count(student.id) = 0;

-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u

-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2
