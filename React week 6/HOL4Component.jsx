import React from 'react';

const HOL4Component = () => {
  const items = ['React', 'JSX', 'Props', 'State'];

  return (
    <ul>
      {items.map((item, index) => <li key={index}>{item}</li>)}
    </ul>
  );
};

export default HOL4Component;
