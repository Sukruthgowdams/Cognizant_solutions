function Greeting({ name }) {
  return <h2>Hello, {name}!</h2>;
}

function App() {
  return (
    <div style={{ padding: '20px' }}>
      <Greeting name="Sukruth" />
      <Greeting name="React Dev" />
    </div>
  );
}

export default App;