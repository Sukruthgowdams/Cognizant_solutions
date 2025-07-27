import React, { useState } from 'react';

const HOL3Component = () => {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>ReactJS HOL 3 - Counter: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
};

export default HOL3Component;
