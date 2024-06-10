<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Result</title>
    <style>
        body {
            background-image: url('staff.jpg');
            background-size: cover;
            
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .message-container {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: rosybrown;
            color: black;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        .button {
            background-color: #B7687D; /* Color that goes well with rosybrown */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
    <script>
        function showMessage() {
            var messageContainer = document.getElementById('message-container');
            messageContainer.style.display = 'block';
        }
    </script>
</head>
<body>
    <div id='message-container' class='message-container'>
        <h2>Your Employee data has been inserted successfully!</h2>
        <a href='managerdash.html' class='button'>Return to Dashboard</a>
    </div>
    <script>
        // Call the showMessage function when the page loads
        window.onload = function() {
            showMessage();
        };
    </script>
</body>
</html>
