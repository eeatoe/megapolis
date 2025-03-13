document.addEventListener("DOMContentLoaded", function() {
  const button = document.getElementById("arrow-rotate-button");
  const arrow = document.getElementById("arrow");
  const dropdown = document.getElementById("dropdown");
  let hideTimeout; // Переменная для хранения таймера

  button.addEventListener("mouseenter", () => {
      clearTimeout(hideTimeout); // Очищаем таймер, если он установлен
      dropdown.classList.remove("hidden"); // Показываем выпадающее меню
      arrow.style.transform = "rotate(90deg)"; // Вращаем стрелку
  });

  button.addEventListener("mouseleave", () => {
      hideTimeout = setTimeout(() => {
          if (!dropdown.matches(':hover') && !button.matches(':hover')) {
              dropdown.classList.add("hidden"); // Скрываем выпадающее меню
              arrow.style.transform = "rotate(0deg)"; // Возвращаем стрелку в исходное положение
          }
      }, 35); // Задержка в 300 мс (можно изменить по желанию)
  });

  dropdown.addEventListener("mouseenter", () => {
      clearTimeout(hideTimeout); // Очищаем таймер, если мышь наведена на меню
      dropdown.classList.remove("hidden"); // Показываем выпадающее меню
  });

  dropdown.addEventListener("mouseleave", () => {
      hideTimeout = setTimeout(() => {
          if (!button.matches(':hover')) {
              dropdown.classList.add("hidden"); // Скрываем выпадающее меню
              arrow.style.transform = "rotate(0deg)"; // Возвращаем стрелку в исходное положение
          }
      }, 35); // Задержка в 300 мс
  });
});
