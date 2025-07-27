import React from 'react';

const HOL7Component = () => {
  const isLoggedIn = true;

  return (
    <div>
      {isLoggedIn ? <p>Welcome Back!</p> : <p>Please Log In</p>}
    </div>
  );
};

export default HOL7Component;
