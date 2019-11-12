# Declare the full path of the SCA project files
$projectFile="${PSScriptRoot}\..\Database\TestDatabase1\TestDatabase1\TestDatabase1.sqlproj"

# Create the database build artifact object required to deploy the update to the dev database
# (I don't need to 'build' a database as I'm not concerned with validation so use New-DatabaseProjectObject instead of Invoke-DatbaesBuild)
$buildArtifact  = $projectFile | New-DatabaseProjectObject | New-DatabaseBuildArtifact -PackageId TestDatabase1 -PackageVersion 0.0.1

# Defining the target dev databases
$target = New-DatabaseConnection -ServerInstance "." -Database TestProd

# Create the deployment artifacts targeting the dev databases to be updated
$releaseArtifact  = New-DatabaseReleaseArtifact -Source $buildArtifact -Target $target

# Deploy to the dev databases
Use-DatabaseReleaseArtifact $releaseArtifact -DeployTo $target -DisableMonitorAnnotation -SkipPreUpdateSchemaCheck -SkipPostUpdateSchemaCheck


