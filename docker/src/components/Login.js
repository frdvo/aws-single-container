import React from 'react';

export default function Login() {
  return(
    <div>
        <h3>LOGIN PAGE</h3>
        <form>
        <label>
            <p>Username</p>
            <input type="text" />
        </label>
        <label>
            <p>Password</p>
            <input type="password" />
        </label>
        <div>
            <button type="submit">Submit</button>
        </div>
        </form>
    </div>
  )
}