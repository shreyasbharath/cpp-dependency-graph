# Questions

- Parallelise dependency scanning as much as possible to get the best possible performance
- Print out dependency graphs for all components by default if no single component is specified
- Open up the graph automatically after generating an individual graph?
- Allow user to specify a single component and the tool should print only that component
- Switch to detect cyclic dependencies (cyclic dependencies highlighted in rendered file)
- Work with any sort of project structure? Or should this tool recommend an ideal project structure for optimal results?
- Highlight strongly coupled components (i.e. have lots of outgoing/incoming dependencies)
- Provide coupling/cohesion metrics, lookup metrics from Clean Architecture and [this](https://softwareengineering.stackexchange.com/questions/151004/are-there-metrics-for-cohesion-and-coupling)
- should work with any type of include (relative, absolute or just the filenames)
- <system> include vs "project" include (how will this work for third party sources that are not part of the codebase?)
- support prefixes to figure out components?
- support case sensitive component names or not?
- support for a giant `public` include dir where public headers of all components are housed