// Animate Hero Title & Subtitle
gsap.from("#title", { opacity: 0, y: -50, duration: 1 });
gsap.from("#subtitle", { opacity: 0, y: 30, duration: 1, delay: 0.5 });

// Animate each content section on scroll
gsap.utils.toArray(".content-section").forEach((section, i) => {
  gsap.from(section, {
    scrollTrigger: {
      trigger: section,
      start: "top 80%",
    },
    opacity: 0,
    y: 50,
    duration: 0.8,
    delay: i * 0.1
  });
});