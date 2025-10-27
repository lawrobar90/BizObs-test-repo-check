# ACE-Box Partner PowerUp BizObs Extension

A clean, production-ready ACE-Box extension for deploying the Partner PowerUp Business Observability (BizObs) use case with automated dashboard fix for OneAgent compatibility.

## Overview

This extension provides:

- **Partner PowerUp BizObs Application**: Business observability demo platform with customer journey simulation
- **Mattermost Integration**: Team collaboration platform
- **ACE-Box Dashboard**: Custom dashboard with working navigation and proper Dynatrace Groundhog styling
- **OneAgent Compatibility**: Automated fix for dashboard 503 errors caused by OneAgent/Next.js ESM loader conflicts
- **Monaco Configuration**: Pre-configured Dynatrace settings for business event monitoring

## Key Features

### 🎯 **Simplified Dashboard Automation**
- **No Complex K8s Management**: Uses nginx:alpine with OneAgent exclusion annotations
- **Working Navigation**: All three nav sections (How-To, Deployment Preview, Links) functional
- **Proper ACE-Box Styling**: Matches official Dynatrace Groundhog design system
- **No 404 Errors**: Single-page application with JavaScript navigation

### 🚀 **Complete BizObs Integration**
- **Customer Journey Simulation**: Multi-persona traffic generation (Karen, Raj, Alex, Sophia)
- **Demo Scenarios**: Insurance, Retail, Tech, Banking use cases
- **Health Monitoring**: Built-in health checks and admin panel
- **External Access**: Kubernetes ingress with proper load balancing

### 🔧 **ACE-Box Standards**
- **Role-Based Pattern**: Follows ACE-Box conventions
- **Monaco Integration**: Automated Dynatrace configuration
- **OneAgent Ready**: Pre-configured for proper instrumentation
- **Ingress Compatible**: Works with standard ACE-Box ingress classes

## Quick Start

### 1. **Upload to Git Repository**
```bash
# Copy this entire folder to your git repository
git clone https://github.com/YOUR_USERNAME/ace-box-ext-hot-partner-powerup-bizobs.git
cd ace-box-ext-hot-partner-powerup-bizobs
cp -r /path/to/this/folder/* .
git add .
git commit -m "Add Partner PowerUp BizObs extension with dashboard fix"
git push
```

### 2. **Deploy in ACE-Box**
```bash
# In your ACE-Box environment
ace enable https://github.com/YOUR_USERNAME/ace-box-ext-hot-partner-powerup-bizobs.git
```

### 3. **Access Services**
- **Dashboard**: `https://dashboard.{your-domain}/`
- **BizObs App**: `https://bizobs.{your-domain}/`
- **Mattermost**: `https://mattermost.{your-domain}/`

## File Structure

```
ace-box-partner-powerup-bizobs-final/
├── main.yml                           # Main ACE-Box entry point
├── ace-ext.config.yml                 # Extension configuration
├── README.md                          # This file
└── roles/
    └── my-use-case/
        ├── tasks/
        │   └── main.yml               # Clean automation logic
        ├── templates/
        │   ├── dashboard-groundhog.html.j2    # ACE-Box dashboard template
        │   └── bizobs-dashboard.yml.j2        # Dashboard values file
        └── files/
            └── monaco/
                ├── manifest.yml       # Monaco configuration manifest
                └── deploy/
                    ├── config.yaml    # Monaco deployment config
                    └── *.json         # Sensor and pipeline templates
```

## Technical Implementation

### Dashboard Fix Strategy
- **Problem**: OneAgent ESM loader conflicts with Next.js dashboard causing 503 errors
- **Solution**: Replace with nginx:alpine serving static HTML with OneAgent exclusions
- **Result**: Clean ACE-Box styling with working navigation and no compatibility issues

### Deployment Pattern
1. **Dependencies**: Install Node.js, OneAgent, Monaco
2. **Monaco Configuration**: Deploy Dynatrace settings before app starts
3. **BizObs Application**: Clone and start with comprehensive startup script
4. **Dashboard Replacement**: Deploy nginx-based dashboard with proper styling
5. **External Access**: Create Kubernetes service/ingress for public access
6. **Collaboration Tools**: Deploy Mattermost for team coordination

### OneAgent Compatibility
```yaml
annotations:
  oneagent.dynatrace.com/injection: "false"
  dynatrace.com/inject: "false" 
  dynatrace/process-group: "false"
```

## Customization

### Update Repository URL
In `roles/my-use-case/tasks/main.yml`, change:
```yaml
bizobs_repo_url: "https://github.com/YOUR_USERNAME/Partner-PowerUp-BizObs-App.git"
```

### Modify Dashboard Content
Edit `roles/my-use-case/templates/dashboard-groundhog.html.j2` to customize:
- Tab content (Dynatrace, BizObs Application, Mattermost descriptions)
- Use Cases section
- Links section
- Navigation structure

### Add Monaco Configurations
Place additional Dynatrace configurations in:
```
roles/my-use-case/files/monaco/deploy/
├── config.yaml        # Reference new configs
└── your-config.json   # New configuration templates
```

## Troubleshooting

### Dashboard 503 Errors
- **Cause**: OneAgent ESM loader conflicts with Next.js
- **Fix**: This extension automatically replaces with nginx:alpine
- **Verification**: Check pod annotations include OneAgent exclusions

### BizObs Application Not Starting
- **Check logs**: `tail -f /tmp/bizobs-startup.log`
- **Verify Node.js**: Ensure Node.js v18.20.1 is installed
- **Port conflicts**: Ensure port 8080 is available

### Ingress Issues
- **Domain resolution**: Verify DNS points to your cluster
- **Ingress class**: Ensure `ingress_class` variable matches your setup
- **Certificate issues**: Check if HTTPS is properly configured

## Production Considerations

### Security
- **Credentials**: Use ACE-Box standard credential management
- **Network**: Ensure proper firewall rules for ingress
- **Updates**: Regularly update base images and dependencies

### Performance
- **Resource limits**: Add appropriate CPU/memory limits to deployments
- **Scaling**: Consider horizontal pod autoscaling for high traffic
- **Monitoring**: Leverage Dynatrace for comprehensive observability

### Maintenance
- **Backup**: Regularly backup Monaco configurations
- **Updates**: Keep OneAgent and application dependencies current
- **Testing**: Validate functionality after ACE-Box framework updates

## Support

For issues related to:
- **ACE-Box Framework**: Consult ACE-Box documentation
- **BizObs Application**: Check Partner PowerUp BizObs repository
- **Dynatrace Integration**: Refer to Monaco v2 documentation
- **Dashboard Styling**: See Dynatrace Groundhog design system

## License

This extension follows the same license as the ACE-Box framework and Partner PowerUp BizObs application.

---

**✅ Ready for Production Deployment**

This extension has been tested and validated for:
- OneAgent compatibility
- ACE-Box integration standards  
- Proper dashboard functionality
- Complete BizObs feature set
- Monaco configuration deployment