# Docker ADD vs. COPY: What are the Differences?
Introduction

**`ADD`** and **`COPY`** are [Docker commands](https://phoenixnap.com/kb/docker-commands-cheat-sheet) for copying files and directories to a [Docker image](https://phoenixnap.com/kb/create-docker-images-with-dockerfile) using a Dockerfile. Although there are differences in the scope of their function, the commands perform the same task.

**This article compares Docker `ADD` vs. `COPY` and advises when to use each command.**

![Docker ADD vs. COPY: What are the differences?](https://phoenixnap.com/kb/wp-content/uploads/2024/01/docker-add-vs-copy-update-2.png)

Docker ADD Command Overview
---------------------------

The **`ADD`** command precedes **`COPY`**, as it has always been part of [Docker](https://phoenixnap.com/kb/what-is-docker). The command copies files and directories to a Docker image [filesystem](https://phoenixnap.com/glossary/filesystem).

The basic syntax for the **`ADD`** command is:

```
ADD [source] … [destination]
```


The syntax includes one or more **`[source]`** files, directories, or URLs, followed by the **`[destination]`** directory on the image's filesystem. If the source is a [directory](https://phoenixnap.com/glossary/what-is-a-directory), the **`ADD`** command copies everything, including file system [metadata](https://phoenixnap.com/glossary/metadata-definition).

To add a locally available [file](https://phoenixnap.com/glossary/what-is-a-file) to an image directory, type:

```
ADD [path-to-local-file] [destination]
```


For example:

```
ADD /home/test/myapp/code.php  /root/myapp 
```


**Note**: The source files and directories must be in the context directory, i.e., the directory where the user will run the **`docker build`** command.

To copy files from a [URL](https://phoenixnap.com/glossary/url-definition-meaning), execute the following command:

```
ADD [file-url] [destination]
```


**`ADD`** can also copy compressed (tarball) files and automatically extract the content at the destination. This feature only applies to locally stored compressed files and directories.

The command extracts a compressed source only if it is in a recognized compression format (based on the file's contents, not the extension). The recognized compression formats include **identity**, **gzip**, **bzip**, and **xz**.

Docker COPY Command Overview
----------------------------

Docker introduced **`COPY`** as an additional command for duplicating content to address some of the **`ADD`** command's functionality issues. The main problem with **`ADD`** is the automatic extraction of the [compressed files](https://phoenixnap.com/glossary/file-compression), which may result in a broken Docker image. This happens if a user does not anticipate the command's behavior.

The **`COPY`** command's only assigned function is to copy the specified files and directories in their existing format. This limitation affects the compressed files, which are copied as-is, i.e., without extraction.

Furthermore, **`COPY`** works with locally stored files only. It cannot be used with URLs to copy external files to an image.

To use **`COPY`**, follow the basic command format:

```
COPY [source] … [destination] 
```


For example, type the following command to copy _index.html_ from the main build context directory to _/usr/local/apache2/htdocs_ in the image:

```
COPY index.html /usr/local/apache2/htdocs 
```


The image below shows the command in a Dockerfile.

![The COPY command in a Dockerfile that creates an Apache server image.](https://phoenixnap.com/kb/wp-content/uploads/2024/01/editing-dockerfile-in-nano-add-vs-copy-update.png)

Docker executes the command when the user starts the build process with **`docker build`**:

```
docker build -t [image-name] .
```


The following image shows **`COPY`** as the second step of the image-building process.

![An output of the docker build command shows the COPY command as the second step in the image building process.](https://phoenixnap.com/kb/wp-content/uploads/2024/01/output-from-docker-build-command-copy-step-add-vs-copy.png)

Docker ADD vs. COPY Command: What Are the Differences?
------------------------------------------------------

In the part where their use cases overlap, **`ADD`** and **`COPY`** work similarly. Both commands copy the contents of the locally available file or directory to the filesystem inside a Docker image.

However, while **`COPY`** has no other functionalities, **`ADD`** can extract compressed files and copy files from a remote location via a URL.

Why Use COPY Instead of ADD in Dockerfile?
------------------------------------------

Docker's official documentation notes that users should always choose **`COPY`** over **`ADD`** since it is a more transparent and straightforward command.

The **`ADD`** command use is discouraged for all cases except when the user wants to extract a local compressed file. For copying remote files, the [run command](https://phoenixnap.com/kb/docker-run-command-with-examples) combined with [wget](https://phoenixnap.com/kb/wget-command-with-examples) or [curl](https://phoenixnap.com/kb/curl-command) is safer and more efficient. This method avoids creating an additional image layer and saves space.

The following example shows the Dockerfile instruction that uses **`RUN`** to download a compressed package from a URL, extract the content, and clean up the archive.

```
RUN curl http://source.file/package.file.tar.gz \
  | tar -xjC /tmp/ package.file.tar.gz \
  && make -C /tmp/ package.file.tar.gz
```


Conclusion

This article compared **`ADD`** and **`COPY`**, the two commands used in Dockerfile to copy files and directories into a Docker image. We presented **`COPY`** as the recommended choice and showed how to minimize **`ADD`** usage in your Dockerfiles.

To learn more about creating Dockerfiles, check out the article on [How to Create Docker Images With Dockerfile](https://phoenixnap.com/kb/create-docker-images-with-dockerfile).