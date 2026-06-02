<?= $this->extend('layout') ?>
<?= $this->section('content') ?>

<div class="container mt-4">
    <h3>Profil Pengguna</h3>
    <ul>
        <li>Username: <?= session()->get('username'); ?></li>
        <li>Email: <?= session()->get('email'); ?></li>
        <li>Role: <?= session()->get('role'); ?></li>
        <li>Login Time: <?= session()->get('login_time'); ?></li>
        <li>Status: <?= session()->get('isLoggedIn') ? 'Login' : 'Logout'; ?></li>
    </ul>
</div>

<?= $this->endSection() ?>