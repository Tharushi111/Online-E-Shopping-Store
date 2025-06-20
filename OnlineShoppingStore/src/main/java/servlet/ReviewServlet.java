	package servlet;
	
	import model.Review;
	import service.ReviewService;
	
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;
	import java.io.IOException;
	import java.util.List;
	
	@WebServlet("/user/reviews")
	public class ReviewServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private ReviewService reviewService;
	
	    @Override
	    public void init() throws ServletException {
	        reviewService = new ReviewService();
	    }
	
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	
	        HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("user") == null) {
	            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
	            return;
	        }
	
	        int userId = (int) session.getAttribute("userId");
	
	        String mode = request.getParameter("mode");
	        if (mode == null) mode = "list";
	        request.setAttribute("mode", mode);
	
	        if ("edit".equals(mode) || "view".equals(mode)) {
	            int reviewId = Integer.parseInt(request.getParameter("id"));
	            Review review = reviewService.getReviewById(reviewId);
	            request.setAttribute("currentReview", review);
	        }
	
	        List<Review> reviews = reviewService.getReviewsByUserId(userId);
	        request.setAttribute("reviews", reviews);
	
	        request.getRequestDispatcher("/client/user/MyReviews.jsp").forward(request, response);
	    }
	
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	
	        HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("user") == null) {
	            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
	            return;
	        }
	
	        String action = request.getParameter("action");
	        String message = null;
	        boolean isError = false;
	
	        try {
	            switch (action) {
	                case "create":
	                    Review newReview = new Review();
	                    newReview.setUserId((int) session.getAttribute("userId"));
	                    newReview.setProductId(Integer.parseInt(request.getParameter("productId")));
	                    newReview.setRating(Integer.parseInt(request.getParameter("rating")));
	                    newReview.setComment(request.getParameter("comment"));
	
	                    if (reviewService.createReview(newReview)) {
	                        message = "Review submitted successfully.";
	                    } else {
	                        message = "Failed to submit review.";
	                        isError = true;
	                    }
	                    break;
	
	                case "update":
	                    Review updatedReview = new Review();
	                    updatedReview.setReviewId(Integer.parseInt(request.getParameter("id")));
	                    updatedReview.setRating(Integer.parseInt(request.getParameter("rating")));
	                    updatedReview.setComment(request.getParameter("comment"));
	
	                    if (reviewService.updateReview(updatedReview)) {
	                        message = "Review updated successfully.";
	                    } else {
	                        message = "Failed to update review.";
	                        isError = true;
	                    }
	                    break;
	
	                case "delete":
	                    int deleteId = Integer.parseInt(request.getParameter("id"));
	                    if (reviewService.deleteReview(deleteId)) {
	                        message = "Review deleted successfully.";
	                    } else {
	                        message = "Failed to delete review.";
	                        isError = true;
	                    }
	                    break;
	
	                default:
	                    message = "Unknown action.";
	                    isError = true;
	            }
	        } catch (Exception e) {
	            message = "Error: " + e.getMessage();
	            isError = true;
	        }
	
	        if (isError) {
	            request.getSession().setAttribute("error", message);
	        } else {
	            request.getSession().setAttribute("success", message);
	        }
	
	        response.sendRedirect(request.getContextPath() + "/user/reviews");
	    }
	}
