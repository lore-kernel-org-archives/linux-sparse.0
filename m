From: "Geoff Johnstone" <geoffsheep.johnstonefrog@googlemail.com>
Subject: Re: multiple source files [was four sparse patches]
Date: Fri, 2 May 2008 19:58:06 +0100
Message-ID: <32e600e90805021158vb6be3c9jbb75c3a61345448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:45158 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbYEBS6I (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 May 2008 14:58:08 -0400
Received: by el-out-1112.google.com with SMTP id n30so638011elf.21
        for <linux-sparse@vger.kernel.org>; Fri, 02 May 2008 11:58:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

> > I've attached four patches that I've written for sparse to use it
> > for a userland project.
>
>  Regarding incomplete structs, your patch seems reasonable as far as
>  I know, and it doesn't break the test suite, so I've applied and
>  pushed it.  Per your concerns, if this patch doesn't represent the
>  correct fix, the code can change later when we have a test case
>  that breaks with this patch.  Please do consider writing a patch
>  for a new test case based on your example.

OK - I sat down to write a test case and had trouble reproducing
because it turns out that the problem has a different cause.
Take three files:

/* test.h */
typedef struct foo *Foo;

void a (Foo foo);
void b (Foo foo);


/* test1.c */
#include "test.h"
void a (Foo foo) { }


/* test2.c */
#include "test.h"
void b (Foo foo) { }


With sparse 0.4.1:

$ sparse test1.c
$ sparse test2.c
$ sparse test[12].c
test2.c:3:6: error: symbol 'b' redeclared with different type
(originally declared at test.h:4) - incompatible argument 1 (different
base types)

...i.e. the problem only occurs with multiple source files on the
sparse command line. (The userland project mentioned above has a build
system that invokes the compiler once, passing all necessary source
files, because it also builds on Windows, where process creation is
remarkably slow so invoking cl.exe once per source file is prohibitive).

I think that the problem may be rooted in main():
  // Expand, linearize and show it.
  check_symbols(sparse_initialize(argc, argv, &filelist));
  FOR_EACH_PTR_NOTAG(filelist, file) {
    check_symbols(sparse(file));
  } END_FOR_EACH_PTR_NOTAG(file);

i.e. sparse doesn't reinitialize for each source file.

My patch a few weeks ago silences the error, but in the light of this
I think that it's working around rather than fixing the problem. The
"correct" fix would seem to be to re-initialise sparse for each source
file. However, sparse's data structures weren't written with this in
mind, so a patch would be rather invasive. It might be simpler to say
that sparse must only be invoked on one source file and to modify cgcc
instead?
