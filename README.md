# s3_mdtest
A version of mdtest that supports a restful S3 interface

mdtest version 1.9.3 was used as the basis for this modification.  The basic methodology was to modify all file/dir create, stat, and deletes to a bucket/object create stat and delete structure.  s3_mdtest uses a forked modified version of vladistan/aws4c to create and configure the correct Amazon Web Services header to eventually target an S3 based platform.  

As of this writing the forked version has a pull request against the master.  The forked, modified version is currently residing in jti-lanl/aws4c.

