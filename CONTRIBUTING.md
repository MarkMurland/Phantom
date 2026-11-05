# Contributing to Phantom

Thanks for your interest in improving Phantom. This guide explains how to report Phantom-specific issues and propose contributions.

Phantom is derived from the Redot Engine and Godot Engine. Their documentation and contribution guides may help explain inherited systems, but they describe upstream projects and may not match Phantom. Phantom-specific reports and proposals belong in [this repository's issue tracker](https://github.com/MarkMurland/Phantom/issues).

## Community conduct

The Phantom community welcomes everyone who comes in peace to support the project.

Responsible behavior based on mutual respect is expected from everyone who participates in Phantom discussions, issue threads, pull requests, and community spaces. We are here to build, share, and improve the engine in a constructive environment.

If behavior becomes disruptive or harmful, maintainers may take action to restore a more productive and respectful atmosphere. This includes removing disruptive comments, restricting access when necessary, or otherwise enforcing community standards.

We welcome contributions from all people regardless of political view, background, identity, or experience. We do not ask for unrelated personal details, and we do not tolerate harassment, abuse, or hostility. Please keep the focus on the project, the code, and the work.

This project brings together people with different experience levels and perspectives, from hobbyists to professional developers. Please be courteous, constructive, and respectful. The goal is to create a healthy, welcoming place for game development and engine work.

## Reporting bugs

Before filing a report, check the [Phantom issues](https://github.com/MarkMurland/Phantom/issues) to see whether it has already been reported. Open a new issue in this repository and follow the issue template.

Please include:

- Phantom version/build and your operating system.
- Clear steps to reproduce the problem and what you expected to happen.
- A minimal reproduction project when practical. Remove generated `.godot` files and unrelated content before sharing.
- Whether the issue also occurs in the relevant upstream Redot or Godot version, if you have tested it. This comparison is helpful but not required; report Phantom issues here either way.
- For a regression, the last version that worked and the first version you found to be affected, if known.

## Proposing features or improvements

Open a discussion or issue in the [Phantom repository](https://github.com/MarkMurland/Phantom/issues) describing the problem, who it affects, and the proposed solution. For substantial changes, please discuss the idea before investing in implementation. Feature proposals are subject to the project's priorities and maintainer decision.

## Contributing pull requests

1. For significant changes, open or find a Phantom issue first and discuss the approach.
2. Make focused changes that address one topic, and include tests or documentation updates where appropriate.
3. Follow the established code style and run relevant checks. The upstream [Redot code style guide](https://docs.redotengine.org/en/stable/contributing/development/code_style_guidelines.html) may be a useful reference, but Phantom maintainers determine what is appropriate here. Use [Pre-Commit](https://pre-commit.com/) where applicable.
4. Review the [AI policy](AI_POLICY.md) if you use AI tools.
5. Submit a pull request describing the change, how it was tested, and any relevant issue. A pull request is a proposal, not a guarantee of acceptance. The project owner/maintainer has final authority over review, merging, feature inclusion, and Phantom's direction; any contribution may be declined or require changes.

### Commits

Keep commits focused and messages clear. A useful commit title is concise, starts with a verb, and describes the change (for example, `Fix input event handling` or `Add editor setting`). If a pull request fixes an issue, use a GitHub closing keyword such as `Fixes #123` in the pull request description.

### Documentation and tests

Update documentation when a change affects user-facing behavior or the scripting API. Add comments for non-obvious implementation details. Bug fixes and new features should include tests where practical; explain in the pull request when tests are not feasible.

Upstream guides for [class reference updates](https://docs.redotengine.org/en/latest/contributing/documentation/updating_the_class_reference.html), [documentation writing](https://docs.redotengine.org/en/latest/contributing/documentation/docs_writing_guidelines.html), and [unit testing](https://docs.redotengine.org/en/latest/contributing/development/core_and_modules/unit_testing.html) can be useful background, though they may need adaptation for Phantom.

## Upstream contributions and documentation

This repository is the place to report problems with Phantom and propose changes to Phantom. If you have confirmed that an issue is exclusively in Redot or Godot and also affects those upstream projects, report it to the relevant upstream project as well. Please keep Phantom reports here so Phantom users and maintainers can track the impact on this fork.

Thank you for helping improve Phantom.
