frappe.ready(function(){
    $(document).ready(function(){
        console.log("code is running ")
        let sidebar = $(".layout-sidebar-section").html();
        let secondaryNav = `
        <nav class="secondary-navbar">
        <ul class="nav-links">${sidebar}</ul></nav>
        `;
        $(".navbar").after(secondaryNav);
        $(".layout-side-section").hide();
    });
});