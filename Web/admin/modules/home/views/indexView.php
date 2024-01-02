<?php require 'layout/header.php'; ?>
<div id="main-content-wp" class="list-post-page">
    <div class="wrap clearfix">
        <?php require 'layout/sidebar.php'; ?>
        <div id="content" class="fl-right">
            <div class="section" id="title-page">
                <div class="clearfix">
                    <h3 id="index" class="fl-left"><span style="color:red">Xin chào <?php echo $_SESSION['fullname'] ;?></h3>  
            </div>
        </div>
    </div>
</div>
<?php require 'layout/footer.php'; ?>