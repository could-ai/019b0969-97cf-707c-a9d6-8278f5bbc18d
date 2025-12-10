import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'
import { Configuration, PlaidApi, PlaidEnvironments } from 'https://esm.sh/plaid@15'

const configuration = new Configuration({
  basePath: PlaidEnvironments.sandbox,
  baseOptions: {
    headers: {
      'PLAID-CLIENT-ID': Deno.env.get('PLAID_CLIENT_ID'),
      'PLAID-SECRET': Deno.env.get('PLAID_SECRET'),
    },
  },
})
const plaidClient = new PlaidApi(configuration)

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })

  const { publicToken } = await req.json()
  const response = await plaidClient.itemPublicTokenExchange({ public_token: publicToken })
  const accessToken = response.data.access_token

  // Fetch transactions
  const transactionsResponse = await plaidClient.transactionsGet({
    access_token: accessToken,
    start_date: '2023-01-01',
    end_date: '2023-12-31',
  })

  return new Response(JSON.stringify(transactionsResponse.data.transactions), { headers: corsHeaders })
})