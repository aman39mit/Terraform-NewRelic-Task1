resource "newrelic_alert_policy" "alert_policy_name" {
  name = "Alert By Aman"
}



# NRQL alert condition
resource "newrelic_nrql_alert_condition" "foo" {
  count = length(var.ApName)
  policy_id                    = newrelic_alert_policy.alert_policy_name.id
  type                         = "static"
  name                         = var.ApName[count.index]
  description                  = "Alert when transactions are taking too long"
  runbook_url                  = "https://www.example.com"
  enabled                      = true
  violation_time_limit_seconds = 3600

  nrql {
    query             = "SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE `entityGuid` = 'MzkzMzUyOHxJTkZSQXxOQXwyMjc2MjE3MDc2MTMwMzAzMTA'"
  }

  critical {
    operator              = "above"
    threshold             = 5.5
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }
}