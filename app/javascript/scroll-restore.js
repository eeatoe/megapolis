document.addEventListener("DOMContentLoaded", function () {
  const scrollPosition = sessionStorage.getItem("scrollPosition");
  if (scrollPosition) {
      window.scrollTo(0, scrollPosition);
  }

  window.addEventListener("beforeunload", function () {
      sessionStorage.setItem("scrollPosition", window.scrollY);
  });
});
