From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 14:00:26 +0000
Message-ID: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:32842 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbdA0OBO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 09:01:14 -0500
Received: by mail-ua0-f170.google.com with SMTP id i68so205031458uad.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 06:00:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi

I am investigating some assertion failures I am getting from LLVM when
trying to compile some test code. Following is a simple test program
that is failing.

typedef unsigned long long size_t;
extern void *malloc(size_t);
struct foo {
        int i;
};
typedef struct foo foo;
foo*  testfunc(void);
foo* testfunc(void) {
        foo *p = (foo *) malloc(sizeof(struct foo));
        return p;
}

There were two failures. First one occurs in the result of the
sizeof() expression - it seems the builder tries to create an integer
constant but passes LLVM a 'char *' as the type, which causes an
assertion failure in LLVM. This error occurs in pseudo_to_value()
function in sparse-llvm.c for the case PSEUDO_VAL. I worked around
this by checking if the type is a pointer and then asking LLVM to
create an integer constant of appropriate size (not sure why the type
is a pointer type here).

Here is the output from test-linearize:

testfunc:
.L0x7ffae85d1010:
 <entry-point>
 call.64     %r1 <- malloc, $4
 cast.64     %r2 <- (64) %r1
 ret.64      %r2

The second LLVM assertion failure occurs in the cast to (64).

My question is this - does this cast look correct? Should it not be a
pointer cast rather than an integer cast?

Also the output from test-linearize and test-parsing do not seem to
dump the types. How can I get the types dumped out as well?

Thanks and Regards
Dibyendu
