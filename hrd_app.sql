-- Membuat database untuk sistem manajemen proyek
CREATE DATABASE project_management;
USE project_management;

-- Membuat tabel 'users' untuk menyimpan data pengguna
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Team Leader', 'Team Member') NOT NULL,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255)
);

-- Membuat tabel 'projects' untuk menyimpan data proyek
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    vendor VARCHAR(100),
    deadline DATE,
    description TEXT,
    status ENUM('ongoing', 'completed') DEFAULT 'ongoing'
);

-- Membuat tabel 'team_members' untuk menyimpan data anggota tim dalam proyek
CREATE TABLE team_members (
    team_member_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    project_id INT,
    role VARCHAR(100),
    contact_info VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Membuat tabel 'progress' untuk menyimpan data kemajuan proyek
CREATE TABLE progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    user_id INT,
    date DATE,
    progress_detail TEXT,
    progress_percentage INT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Menambahkan data pengguna (pemain dan pelatih) ke tabel 'users'
INSERT INTO users (username, password, role, name, contact_info) VALUES 
('lead1', 'password123', 'Team Leader', 'Lionel Messi', 'messi@example.com'),
('dev1', 'password123', 'Team Member', 'Cristiano Ronaldo', 'ronaldo@example.com'),
('dev2', 'password123', 'Team Member', 'Neymar Jr', 'neymar@example.com'),
('lead2', 'password456', 'Team Leader', 'Kylian Mbappe', 'mbappe@example.com'),
('dev3', 'password456', 'Team Member', 'Robert Lewandowski', 'lewandowski@example.com'),
('dev4', 'password456', 'Team Member', 'Mohamed Salah', 'salah@example.com');

-- Menambahkan data proyek IT ke tabel 'projects'
INSERT INTO projects (project_name, vendor, deadline, description, status) VALUES 
('Website Redesign', 'TechCorp', '2024-09-30', 'Redesign of the company website with new features', 'ongoing'),
('Mobile App Development', 'AppSolutions', '2024-11-30', 'Development of a new mobile app for e-commerce', 'ongoing'),
('Database Migration', 'DataMasters', '2024-10-15', 'Migration of legacy database to new system', 'completed');

-- Menambahkan anggota tim ke proyek
INSERT INTO team_members (user_id, project_id, role, contact_info) VALUES 
(1, 1, 'Project Manager', 'messi@example.com'), -- Lionel Messi sebagai Project Manager untuk Website Redesign
(2, 1, 'Front-end Developer', 'ronaldo@example.com'), -- Cristiano Ronaldo sebagai Front-end Developer untuk Website Redesign
(3, 1, 'Back-end Developer', 'neymar@example.com'), -- Neymar Jr sebagai Back-end Developer untuk Website Redesign
(4, 2, 'Project Manager', 'mbappe@example.com'), -- Kylian Mbappe sebagai Project Manager untuk Mobile App Development
(5, 2, 'Mobile Developer', 'lewandowski@example.com'), -- Robert Lewandowski sebagai Mobile Developer untuk Mobile App Development
(6, 2, 'UI/UX Designer', 'salah@example.com'), -- Mohamed Salah sebagai UI/UX Designer untuk Mobile App Development
(1, 3, 'Project Manager', 'messi@example.com'), -- Lionel Messi sebagai Project Manager untuk Database Migration
(2, 3, 'Database Specialist', 'ronaldo@example.com'); -- Cristiano Ronaldo sebagai Database Specialist untuk Database Migration

-- Menambahkan data kemajuan proyek ke tabel 'progress'
INSERT INTO progress (project_id, user_id, date, progress_detail, progress_percentage) VALUES 
(1, 2, '2024-07-31', 'Completed homepage redesign', 40), -- Cristiano Ronaldo menyelesaikan desain ulang homepage untuk Website Redesign
(1, 3, '2024-07-31', 'Integrated new API for user authentication', 30), -- Neymar Jr mengintegrasikan API baru untuk autentikasi pengguna untuk Website Redesign
(2, 5, '2024-07-31', 'Finished mobile app development phase 1', 35), -- Robert Lewandowski menyelesaikan fase 1 pengembangan mobile app untuk Mobile App Development
(2, 6, '2024-07-31', 'Completed wireframes and design prototypes', 25), -- Mohamed Salah menyelesaikan wireframes dan prototipe desain untuk Mobile App Development
(3, 2, '2024-07-31', 'Completed database schema migration', 50); -- Cristiano Ronaldo menyelesaikan migrasi skema database untuk Database Migration

-- Query untuk menampilkan semua proyek yang sedang berjalan
SELECT project_name, vendor, deadline, status 
FROM projects 
WHERE status = 'ongoing';

-- Query untuk menampilkan anggota tim dan kontak mereka
SELECT u.name, tm.role, u.contact_info 
FROM team_members tm 
JOIN users u ON tm.user_id = u.user_id;

-- Query untuk menampilkan progress berdasarkan anggota tim
SELECT p.project_name, pr.date, pr.progress_detail, pr.progress_percentage
FROM progress pr
JOIN projects p ON pr.project_id = p.project_id
WHERE pr.user_id = ?;  -- Ganti ? dengan user_id anggota tim yang sesuai

-- Query untuk menampilkan semua progress
SELECT u.name, p.project_name, pr.date, pr.progress_detail, pr.progress_percentage
FROM progress pr
JOIN users u ON pr.user_id = u.user_id
JOIN projects p ON pr.project_id = p.project_id;
