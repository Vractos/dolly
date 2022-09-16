import { useAuth0 } from "@auth0/auth0-react";
import React from "react";

const LogoutButton = () => {
  const { logout, getAccessTokenSilently } = useAuth0();

  return (
    // <button onClick={() => logout({ returnTo: window.location.origin })}>
    <button onClick={() => getAccessTokenSilently({audience: import.meta.env.VITE_AUTH0_AUDIENCE}).then(s => console.log(s))}>
      Log Out
    </button>
  );
};

export default LogoutButton;