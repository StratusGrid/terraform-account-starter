provider "aws" {
  region              = var.region
  default_tags {
    tags = merge(
      local.common_tags,
      { Region_Purpose = "Active" }
    )
  }
}

#Extra Providers for Config and other Multi-Region configurations like AWS Config
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  default_tags {
    tags = merge(
      local.common_tags,
      { Region_Purpose = "Active" }
    )
  }
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  default_tags {
    tags = merge(
      local.common_tags,
      { Region_Purpose = "Active" }
    )
  }
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
  default_tags {
    tags = merge(
      local.common_tags,
      { Region_Purpose = "Active" }
    )
  }
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  default_tags {
    tags = merge(
      local.common_tags,
      { Region_Purpose = "Active" }
    )
  }
}