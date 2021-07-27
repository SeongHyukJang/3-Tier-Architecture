resource "aws_backup_vault" "backup_vault" {
    name = "70491-backup-vault"
    kms_key_arn = "arn:aws:kms:ap-northeast-2:533616270150:key/9a0e4c93-4fba-48b6-aeee-7f6886c890a0"
}

resource "aws_backup_plan" "backup_plan" {
    name = "70491-backup-plan"

    rule {
        rule_name = "backup-rule"
        target_vault_name = aws_backup_vault.backup_vault.name
    }
}

resource "aws_backup_selection" "backup_web" {
    iam_role_arn = "arn:aws:iam::533616270150:role/service-role/AWSBackupDefaultServiceRole"
    name = "backup-WEB"
    plan_id = aws_backup_plan.backup_plan.id

    selection_tag {
        type = "STRINGEQUALS"
        key = "Name"
        value = "70491-WEB"
    }
}

resource "aws_backup_selection" "backup_was" {
    iam_role_arn = "arn:aws:iam::533616270150:role/service-role/AWSBackupDefaultServiceRole"
    name = "backup-WAS"
    plan_id = aws_backup_plan.backup_plan.id

    selection_tag {
        type = "STRINGEQUALS"
        key = "Name"
        value = "70491-WAS"
    }
}

resource "aws_backup_selection" "backup_db" {
    iam_role_arn = "arn:aws:iam::533616270150:role/service-role/AWSBackupDefaultServiceRole"
    name = "backup-DB"
    plan_id = aws_backup_plan.backup_plan.id

    selection_tag {
        type = "STRINGEQUALS"
        key = "Name"
        value = "70491-DB"
    }   
}