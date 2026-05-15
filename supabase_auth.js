// Exemplo de validação de login com Supabase em JavaScript.
// Substitua as variáveis SUPABASE_URL e SUPABASE_ANON_KEY
// pelos valores do seu projeto Supabase.

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://bfsswjbeugjqflcnmkrd.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmc3N3amJldWdqcWZsY25ta3JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg4MjAxNzcsImV4cCI6MjA5NDM5NjE3N30.EyC4ctGxvUciWAy7S_qesVVOP003rzUQHiNRUx6Kh_0';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

export async function signIn(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (error) {
    console.error('Erro ao autenticar:', error.message);
    return null;
  }

  return data.user;
}

export async function signUp(name, email, password) {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: {
        full_name: name,
      },
    },
  });

  if (error) {
    console.error('Erro ao registrar:', error.message);
    return null;
  }

  return data.user;
}

export async function validateCredentials(email, password) {
  const user = await signIn(email, password);
  if (!user) {
    return false;
  }
  return true;
}
