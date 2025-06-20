// Animation on scroll
document.addEventListener('DOMContentLoaded', () => {
    const animateOnScroll = () => {
        const elements = document.querySelectorAll('.product-card, .category-card, .about-content, .mobile-app, .promo-card, .contact-container');
        
        elements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const elementBottom = element.getBoundingClientRect().bottom;
            
            if (elementTop < window.innerHeight && elementBottom > 0) {
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }
        });
    };

    // Initial animation setup
    document.querySelectorAll('.product-card, .category-card, .about-content, .mobile-app, .promo-card, .contact-container').forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        element.style.transition = 'all 0.6s ease-out';
    });

    window.addEventListener('scroll', animateOnScroll);
    animateOnScroll(); // Initial check
});

// Auth Modal
const modal = document.getElementById('authModal');
const signInBtn = document.querySelector('.sign-in');
const signUpBtn = document.querySelector('.sign-up');
const closeBtn = document.querySelector('.close');
const tabBtns = document.querySelectorAll('.tab-btn');
const tabContents = document.querySelectorAll('.tab-content');

// Open modal
signInBtn.addEventListener('click', () => {
    modal.style.display = 'block';
    showTab('signin');
});

signUpBtn.addEventListener('click', () => {
    modal.style.display = 'block';
    showTab('signup');
});

// Close modal
closeBtn.addEventListener('click', () => {
    modal.style.display = 'none';
});

window.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.style.display = 'none';
    }
});

// Tab switching
function showTab(tabId) {
    tabBtns.forEach(btn => {
        btn.classList.remove('active');
        if (btn.dataset.tab === tabId) {
            btn.classList.add('active');
        }
    });

    tabContents.forEach(content => {
        content.style.display = 'none';
        if (content.id === tabId) {
            content.style.display = 'block';
        }
    });
}

tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        showTab(btn.dataset.tab);
    });
});

// Form submission
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', (e) => {
        e.preventDefault();
        // Add your authentication logic here
        alert('Form submitted successfully!');
    });
});

// Contact form submission
const contactForm = document.querySelector('.contact-form');
if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
        e.preventDefault();
        alert('Message sent successfully! We will get back to you soon.');
        contactForm.reset();
    });
}

// Smooth scroll for navigation
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});