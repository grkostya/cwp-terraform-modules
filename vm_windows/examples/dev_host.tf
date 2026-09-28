locals {
  env = lower(terraform.workspace)

  devhost_admin_username = "azureuser"

  devhost_custom_script_ps      = <<-CUSTOMDATA
        $Directory = 'C:/Install' ; New-Item -Path $Directory -ItemType Directory;
        cd $Directory ;

        $ProgressPreference = 'SilentlyContinue';
        Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile ./AzureCLI.msi;
        Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet';

        az aks install-cli ;

        $script_file = 'C:/Install/get_latest_kubectl.ps1' ;
        sc -Path $script_file -value  '$Directory = {C:/Install}' ;
        ac -Path $script_file -value  '$kubectl_version = (Invoke-WebRequest -Uri https://storage.googleapis.com/kubernetes-release/release/stable.txt).Content' ;
        ac -Path $script_file -value  'Invoke-WebRequest -Uri https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/windows/amd64/kubectl.exe -OutFile $Directory/kubectl.exe' ;
        ac -Path $script_file -value  'Copy-Item -Path $Directory/kubectl.exe -Destination C:/Windows' ;
        ac -Path $script_file -value  '$kubelogin_version = (Invoke-WebRequest -Uri https://api.github.com/repos/Azure/kubelogin/releases/latest | Select-Object -ExpandProperty Content | ConvertFrom-Json).tag_name' ;
        ac -Path $script_file -value  'Invoke-WebRequest -Uri https://github.com/Azure/kubelogin/releases/download/$kubelogin_version/kubelogin-win-amd64.zip -OutFile $Directory/kubelogin.zip' ;
        ac -Path $script_file -value  'Expand-Archive -Path $Directory/kubelogin.zip -DestinationPath $Directory/kubelogin' ;
        ac -Path $script_file -value  '$kubelogin_file = (Get-Childitem $Directory/kubelogin -Recurse -Filter kubelogin.exe).FullName' ;
        ac -Path $script_file -value  'Copy-Item -Path $kubelogin_file -Destination C:/Windows' ;


        $script_file = 'C:/Users/Public/Desktop/aks_get-credentials.cmd' ;
        sc -Path $script_file -value  '@call az login --use-device-code'  ;
        ac -Path $script_file -value  '@call az aks get-credentials -n ${aks_cluster_name} -g ${resource_group_name} --overwrite' ;
        ac -Path $script_file -value  '@call kubectl config set-context --current --namespace board-navigator-${local.env} >nul' ;
        ac -Path $script_file -value  '@call kubectl config get-contexts && pause';

        for ($i=1; $i -le 3; $i++) { New-LocalUser -Disabled -Name dev-team-$i -Password (ConvertTo-SecureString '${try(random_password.devhost_dev_users_password[0].result, "")}' -AsPlainText -Force) } ;

    CUSTOMDATA
  devhost_custom_script_escaped = replace(local.devhost_custom_script_ps, "\n", "")
}




resource "random_password" "devhost_admin_password" {
  length           = 20
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "random_password" "devhost_dev_users_password" {
  length           = 16
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!#$%&*-_=+?"
}




module "DEVHOST" {
  source = "../../../modules/vm_windows"

  vm_name                = "vm-devhost-${local.env}"
  computer_name          = local.env
  resource_group         = azurerm_resource_group.this
  subnet_id              = module.VNE.subnet_id
  vm_size                = "Standard_B2ls_v2"
  admin_username         = local.devhost_admin_username
  admin_password         = random_password.devhost_admin_password[0].result
  disk_encryption_set_id = azurerm_disk_encryption_set.AKS_DES.id
  patch_assessment_mode  = "AutomaticByPlatform"
  patch_mode             = "AutomaticByPlatform"
}




resource "azurerm_virtual_machine_extension" "devhost_custom_script" {
  name                 = "init_powershell_script"
  virtual_machine_id   = module.DEVHOST[0].vm_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {

        "commandToExecute": "powershell -Command \"& { ${local.devhost_custom_script_escaped} }\""
    }
  SETTINGS
}




# To enable EntraID authentication
resource "azurerm_virtual_machine_extension" "AADLoginForWindows" {
  name                 = "AADLoginForWindows"
  virtual_machine_id   = module.DEVHOST[0].vm_id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.6.2"
    }
  }
}
