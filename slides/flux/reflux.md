### Why reflux?

<div style="float:left; width:48%">
  <h4>Flux</h4>
  <ul>
    <li>Singleton dispatcher</li>
    <li>Actions are strings</li>
    <li>Stores use <pre style="display: inline">switch</pre></li>
    <li><pre style="display: inline">Dispatcher.waitFor([])</pre></li>
  </ul>
</div>
<div style="float:left; width:48%">
  <h4>reflux</h4>
  <ul>
    <li>No dispatcher</li>
    <li>Actions are functions</li>
    <li>Stores listen to actions</li>
    <li>Chained stores or joined listeners</li>
  </ul>
</div>