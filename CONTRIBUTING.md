# Contributing to Development CLI Tools

## Development Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run local tests
5. Commit your changes (`git commit -m 'feat: Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

## Code Style

- Use 4 spaces for indentation
- Add comments for complex logic
- Keep functions focused and small
- Use meaningful variable names
- Add error handling where appropriate

## Testing

- Test your changes locally
- Ensure backwards compatibility
- Add new test cases for new features

## Documentation

- Update README.md if needed
- Add inline documentation for new functions
- Update usage information for modified commands

## Pull Request Process

1. Update the README.md with details of changes if needed
2. Update the CHANGELOG.md following the existing format
3. Update the version numbers following [SemVer](https://semver.org/)
4. The PR will be merged once you have the sign-off
