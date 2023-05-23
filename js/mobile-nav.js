function initMobileNav() {  
  document.getElementById("menu-toggle").addEventListener("click", function(event) {
    event.preventDefault();
    document.body.classList.toggle("nav-open");
  })
}

if (document.readyState === "complete" ||
    (document.readyState !== "loading" && !document.documentElement.doScroll)
) {
  initMobileNav()();
} else {
  document.addEventListener("DOMContentLoaded", initMobileNav);
}