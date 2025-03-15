document.addEventListener("DOMContentLoaded", function() {
  const button = document.getElementById("dropdown-trigger");
  const arrow = document.getElementById("arrow");
  const menu = document.getElementById("menu");
  let hideTimeout;

  button.addEventListener("mouseenter", () => {
      clearTimeout(hideTimeout);
      menu.classList.remove("hidden");
      arrow.style.transform = "rotate(90deg)";
  });

  button.addEventListener("mouseleave", () => {
      hideTimeout = setTimeout(() => {
          if (!menu.matches(':hover') && !button.matches(':hover')) {
              menu.classList.add("hidden");
              arrow.style.transform = "rotate(0deg)";
          }
      }, 35); // Задержка в 300 мс (можно изменить по желанию)
  });

  menu.addEventListener("mouseenter", () => {
      clearTimeout(hideTimeout); // Очищаем таймер, если мышь наведена на меню
      menu.classList.remove("hidden"); // Показываем выпадающее меню
  });

  menu.addEventListener("mouseleave", () => {
      hideTimeout = setTimeout(() => {
          if (!button.matches(':hover')) {
              menu.classList.add("hidden"); // Скрываем выпадающее меню
              arrow.style.transform = "rotate(0deg)"; // Возвращаем стрелку в исходное положение
          }
      }, 35); // Задержка в 300 мс
  });
});
