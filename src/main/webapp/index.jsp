<%-- Include the common header --%>
<%@ include file="header.jsp" %>

<main class="main">
    <!--==================== HERO SECTION ====================-->
    <section class="home" id="home">
        <img src="assets/img/kimberly-farmer-lUaaKCUANVI-unsplash.jpg" alt="Learning Dashboard" class="home__img">

        <div class="home__container container grid">
            <div class="home__data">
                <span class="home__data-subtitle">Expand Your Knowledge</span>
                <h1 class="home__data-title">Learn New Skills with <b>Top Courses <br> From Experts</b></h1>
                <a href="courses.jsp" class="button">Explore Courses</a>
            </div>
            <!-- Social links can be retained or adjusted per your needs -->
        </div>
    </section>

    <!--==================== COURSE CATEGORIES ====================-->
    <section class="categories section" id="categories">
        <div class="categories__container container grid">
            <div class="category">
                <img src="assets/img/technology.jpg" alt="Technology" class="category__img">
                <h3 class="category__title">Technology</h3>
                <p class="category__description">From AI to Web Development, advance your career with cutting-edge tech courses.</p>
            </div>
            <div class="category">
                <img src="assets/img/business.jpg" alt="Business" class="category__img">
                <h3 class="category__title">Business</h3>
                <p class="category__description">Empower your entrepreneurial spirit with courses on finance, marketing, and more.</p>
            </div>
            <div class="category">
                <img src="assets/img/creative.jpg" alt="Creative Arts" class="category__img">
                <h3 class="category__title">Creative Arts</h3>
                <p class="category__description">Explore your creativity with courses in design, photography, music, and painting.</p>
            </div>
        </div>
    </section>


    <!--==================== POPULAR COURSES ====================-->
    <section class="popular section" id="popular">
        <div class="popular__container container">
            <!-- Implementation of Swiper.js for a responsive carousel -->
            <div class="swiper-container popular__slider">
                <div class="swiper-wrapper">
                    <!-- Swiper Slide 1 -->
                    <div class="swiper-slide">
                        <img src="assets/img/course1.jpg" alt="Course 1" class="popular__img">
                        <div class="popular__data">
                            <h3 class="popular__title">Data Science for Beginners</h3>
                            <span class="popular__category">Technology</span>
                            <div class="popular__stars">
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-half-fill"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Swiper Slide 2 -->
                    <div class="swiper-slide">
                        <img src="assets/img/course2.jpg" alt="Course 2" class="popular__img">
                        <div class="popular__data">
                            <h3 class="popular__title">Introduction to Web Development</h3>
                            <span class="popular__category">Development</span>
                            <div class="popular__stars">
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-fill"></i>
                                <i class="ri-star-line"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Additional slides can follow the same structure -->
                </div>
                <!-- If you need navigation buttons -->
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <!-- If you need pagination -->
                <div class="swiper-pagination"></div>
            </div>

            <!-- Initialization of Swiper JS for the carousel -->
            <script>
                var swiper = new Swiper('.popular__slider', {
                    slidesPerView: 1,
                    spaceBetween: 10,
                    // Optional parameters
                    loop: true,
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    // Responsive breakpoints
                    breakpoints: {
                        640: {
                            slidesPerView: 2,
                            spaceBetween: 20,
                        },
                        768: {
                            slidesPerView: 3,
                            spaceBetween: 40,
                        },
                        1024: {
                            slidesPerView: 4,
                            spaceBetween: 50,
                        },
                    }
                });
            </script>
        </div>
    </section>


    <!--==================== INSTRUCTORS HIGHLIGHT ====================-->
    <section class="instructors section" id="instructors">
        <div class="instructors__container container grid">
            <div class="instructor">
                <img src="assets/img/instructor1.jpg" alt="Instructor Name" class="instructor__img">
                <h3 class="instructor__name">Alex Johnson</h3>
                <p class="instructor__expertise">Data Science Wizard</p>
                <q class="instructor__quote">"Learning is a treasure that will follow its owner everywhere."</q>
            </div>
        </div>
    </section>


    <!--==================== TESTIMONIALS ====================-->
    <section class="testimonials section" id="testimonials">
        <div class="testimonials__container container">
            <!-- Dynamic testimonials slider -->
        </div>
    </section>


    <!--==================== BECOME AN INSTRUCTOR ====================-->
    <section class="become-instructor section">
        <div class="become-instructor__container container">
            <h2>Teach with Us</h2>
            <p>Share your knowledge and impact millions of students around the globe. Join us as an instructor today!</p>
            <a href="teach.jsp" class="button">Become an Instructor</a>
        </div>
    </section>
</main>

<!--==================== SUBSCRIBE ====================-->
<section class="subscribe section">
    <div class="subscribe__bg">
        <div class="subscribe__container container">
            <h2 class="section__title subscribe__title">Join Our Learning Community</h2>
            <p>Subscribe to receive the latest courses updates, exclusive offers, and learning tips directly to your inbox.</p>
            <!-- Subscription Form Implementation -->
        </div>
    </div>
</section>

<%-- Include the common footer --%>
<%@ include file="footer.jsp" %>
