<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class AuthController extends BaseController
{
    function __construct()
    {
        helper('form');
    }

    public function login()
{
    if ($this->request->getPost()) {
        $username = $this->request->getVar('username');
        $password = $this->request->getVar('password');

        $dataUser = ['username' => 'ilham', 'password' => '72db86e4c73b9fabb4810562b236488e', 'role' => 'admin']; // pass 15626

        if ($username == $dataUser['username']) {
            if (md5($password) == $dataUser['password']) {
                session()->set([
                    'username' => $dataUser['username'],
                    'role' => $dataUser['role'],
                    'isLoggedIn' => TRUE,
                    'email' => 'ilham@gmail.com',
                    'login_time'  => date('Y-m-d H:i:s'),
                ]);

                return redirect()->to(base_url('/'));
            } else {
                session()->setFlashdata('failed', 'Username & Password Salah');
                return redirect()->back();
            }
        } else {
            session()->setFlashdata('failed', 'Username Tidak Ditemukan');
            return redirect()->back();
        }
    } else {
        return view('v_login');
    }
}

public function logout()
{
    session()->destroy();
    return redirect()->to('login');
}
}
