import { ref } from "vue";

const user = ref(JSON.parse(localStorage.getItem("user") || "null"));
const token = ref(localStorage.getItem("token"));

export function useAuth() {
  const isAuthenticated = () => !!token.value;

  const login = (newUser: any, newToken: string) => {
    localStorage.setItem("token", newToken);
    localStorage.setItem("user", JSON.stringify(newUser));

    token.value = newToken;
    user.value = newUser;
  };

  const logout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("user");

    token.value = null;
    user.value = null;

    window.location.href = "/login";
  };

  return {
    user,
    token,
    isAuthenticated,
    login,
    logout
  };
}