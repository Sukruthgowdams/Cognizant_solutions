import React, { useEffect } from 'react';

const HOL6Component = () => {
  useEffect(() => {
    console.log('HOL6Component mounted');
  }, []);

  return <p>ReactJS HOL 6 - useEffect Example</p>;
};

export default HOL6Component;
