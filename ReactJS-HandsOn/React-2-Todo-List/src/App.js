import { useState } from 'react';

function App() {
  const [task, setTask] = useState('');
  const [todos, setTodos] = useState([]);

  const addTask = () => {
    if (task) {
      setTodos([...todos, task]);
      setTask('');
    }
  };

  return (
    <div style={{ padding: '20px' }}>
      <h2>Todo List</h2>
      <input value={task} onChange={e => setTask(e.target.value)} />
      <button onClick={addTask}>Add</button>
      <ul>
        {todos.map((t, idx) => <li key={idx}>{t}</li>)}
      </ul>
    </div>
  );
}

export default App;