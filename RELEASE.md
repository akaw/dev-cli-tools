# Release Process

This document describes the release process for dev-cli-tools.

## Pre-Release Checklis

Before creating a release, ensure all the following items are completed:

### 1. Version Updates
Run the pre-release check to verify version consistency:
```bash
./tests/pre-release-check.sh
```

The script checks:
- [x] Script header version (`# Version: X.X.X` in src/dev)
- [x] Script VERSION variable (`VERSION="X.X.X"` in src/dev)
- [x] README.md version badge
- [x] CHANGELOG.md entry for the new version
- [x] Documentation files exis
- [x] Git working directory status

### 2. Manual Verification
- [ ] Test the script functionality manually
- [ ] Verify all recent bugfixes work as expected
- [ ] Check that no breaking changes were introduced
- [ ] Review CHANGELOG.md for completeness

### 3. Git State
- [ ] All changes committed
- [ ] Working directory clean
- [ ] On main/master branch

## Release Steps

### 1. Automated Release (Recommended)
```bash
# Run pre-release check
./tests/pre-release-check.sh

# If check passes, create release
./scripts/create-release.sh
```

### 2. Manual Release
```bash
# 1. Get current version
VERSION=$(grep '^VERSION=' src/dev | cut -d'"' -f2)

# 2. Commit all changes
git add .
git commit -m "Release v${VERSION}"

# 3. Create and push tag
git tag -a "v${VERSION}" -m "Release v${VERSION}"
git push origin main
git push origin "v${VERSION}"

# 4. Create GitHub release (manual via web interface)
```

## Version Numbering

This project follows Semantic Versioning (semver.org):

- **MAJOR.MINOR.PATCH** forma
- **MAJOR**: Breaking changes
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes, backwards compatible

## Release Types

### Patch Release (X.X.Y+1)
For bug fixes and small improvements:
- Typo fixes
- Bug fixes
- Documentation updates
- Performance improvements (without API changes)

### Minor Release (X.Y+1.0)
For new features that are backwards compatible:
- New commands
- New configuration options
- Enhanced existing functionality

### Major Release (X+1.0.0)
For breaking changes:
- Removed commands or options
- Changed command behavior
- New system requirements

## Post-Release

After creating a release:

1. **Update documentation** if needed
2. **Announce the release** in relevant channels
3. **Monitor for issues** from users
4. **Prepare hotfixes** if critical issues are found

## Hotfix Process

For critical issues in released versions:

1. Create hotfix branch from release tag
2. Apply minimal fix
3. Update version to next patch (e.g., 1.3.5 → 1.3.6)
4. Update CHANGELOG.md
5. Create new release
6. Merge hotfix back to main branch

## Files That Must Be Updated for Each Release

1. **src/dev** (2 locations):
   - Line ~9: `# Version: X.X.X`
   - Line ~15: `VERSION="X.X.X"`

2. **README.md**:
   - Version badge: `version-X.X.X`

3. **CHANGELOG.md**:
   - Add new version entry at the top
   - Include date in format: `## [X.X.X] - YYYY-MM-DD`
   - List all changes under appropriate categories (Added, Changed, Fixed, etc.)
   - For major releases, include performance metrics and migration notes

## Validation

Always run the pre-release check before creating a release:
```bash
./tests/pre-release-check.sh
```

This ensures version consistency across all files and prevents common release errors.