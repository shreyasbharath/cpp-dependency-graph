# Questions

- Parallelise as much as possible to get the best possible performance
- Allow user to specify a single component and the tool should print only that component
- Switch to detect cyclic dependencies (cyclic dependencies highlighted in rendered file)
- Highlight strongly coupled components (i.e. have lots of outgoing/incoming dependencies)
- Provide coupling/cohesion metrics ttps://softwareengineering.stackexchange.com/questions/151004/are-there-metrics-for-cohesion-and-coupling)
- should work with any type of include (relative, absolute or just the filenames)
- <system> include vs "project" include (how will this work for third party sources that are not part of the codebase?)
- support prefixes to figure out components?