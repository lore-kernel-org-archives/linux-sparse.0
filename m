From: alexey.zaytsev@gmail.com
Subject: [PATCH 0/10] Sparse linker
Date: Thu,  4 Sep 2008 01:55:44 +0400
Message-ID: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:30220 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYICVxq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:46 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2911410muf.1
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

Hello.

I've been working on a "sparse linker" this summer as my Google
Summer of Code project. Wasn't neraly as productive as I hoped,
but I've got some results that I would like to share. Moreover,
I plan continuing this work, and would like to hear comments on
what was done so far.

The design didn't change much from what was proposed. We run
sparse to generate a "sparse object" file containing a list of
symbols, then run the "linker" to unite those object files into
bigger ones. This way, in the end we get a file containing all
the global symbols appearing in the program. After learning
more on the subject, I now agree that we should include the
intermediate code representation into the object files.

The implementation is built around a generic serialization
mechanism [PATCH 01]. It handles many sorts of complex data
structures, with pointers, cycles, unions, etc. E.g. it is able
to serialize beasts like the sparse pointer lists. The price
for this is a four byte overhead prepended to every
serializable structure by the allocation wrapper. Also, you
have to use a macro when declaring a serializable structure
(or an array of such) statically. One limitation I was unable
to overcome is the inability to work with structures used both
stand-alone and embedded into bigger ones. Luckily, we have no
such cases in the sparse codebase. The serializer produces C
code, containing the data structures beind serialized. For the
structure definitions, the generated code includes the original
headers, defining the structures. After serializing a bunch of
possibly interconnecded structures, and running cc over the
generated code, one might get a static or dynamic library
containing the copies of the serialized data structures, with
all the pointer interconnections included. This way loading
the data is trivial, and very memory efficient, and the whole
dump-restore process should be totally transparent, e.g. it
should be possible serialize the sparse() output, and run
check_symbols() after loading the data from an other program.
One thing that bothers me, is, if gcc would be able to process
the huge data files, containing all the "code" of bigger
projects like the Linux kernel. Will see.

Being able to serialize any data, generating the symbol lists
becomes as trivial as defining the data structures
corresponding to source files and symbols [PATCH 06], deriving
a symbol list from the sparse output, joining it into a ptr
list and serializing it [PATCH 07]. The linker needs to dlopen
the input "sparse objects", merge the symbol lists, and
serialize the result [PATCH 08]. The generated code compilation
is handled by the cgcc, cld and car wrappers [PATCH 09]. To
look up symbols in sparse object files, a simple program is
included [PATCH 10].

The plan is now to proceed with dumping the linearized code.

Please take a look at the code, ask if anything needs
clarification, and don't hesitate for criticism. If you've got
ideas on how the linker might be extended and used, or
have a different approach to the problem, please drop a message.

You can also look at the code at
http://svcs.cs.pdx.edu/gitweb?p=sparse-soc2008.git;a=shortlog;h=gsoc2008-linker

or grab it from
git://svcs.cs.pdx.edu/git/sparse-soc2008 branch gsoc2008-linker

For those brave that would actually like to see how it works,
that's how I'd run the thing over the sparse codebase:

make CC="cgcc -v -emit-code" LD=cld AR=car
and then
./where sparse.sparse.so linearize_statement

And no, the patches are not ment for mainline inclusion right
now.

P.S:
If you don't like being on the CC list, I'd miss your opinion,
but would drop you from any further notifications on the
project, just drop me a message.


