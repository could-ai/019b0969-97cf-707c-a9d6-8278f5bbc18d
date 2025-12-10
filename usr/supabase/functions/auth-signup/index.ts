import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })

  const supabase = createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!)

  const { email, password } = await req.json()
  const { data, error } = await supabase.auth.signUp({ email, password })

  if (error) return new Response(JSON.stringify({ error: error.message }), { status: 400, headers: corsHeaders })

  return new Response(JSON.stringify(data), { headers: corsHeaders })
})