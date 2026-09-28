locals {
  ## Subscription IDs
  DEV_subscription_id = contains(["dev"], local.env) ? "57e76ab1-a2fb-482a-a0ff-cf89d86151fc" : null ## SUB-ENAI-UAT01
  UAT_subscription_id = contains(["uat"], local.env) ? "f929fe1e-3958-4b2f-966d-f25ed4b088ad" : null ## SUB-ENAI-UAT01
  PRD_subscription_id = contains(["prd"], local.env) ? "cb659b44-d50c-4ab4-81ba-897469cce0ff" : null

  ## Define the current Subscription ID
  subscription_id = coalesce(
    local.DEV_subscription_id,
    local.UAT_subscription_id,
    local.PRD_subscription_id,
  )
}
