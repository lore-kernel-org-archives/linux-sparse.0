From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Thu, 17 Apr 2014 23:29:39 -0700
Message-ID: <CANeU7QnpBiJWb8Qx0r1Y=7kjvQwFkuwWuM0dkBdK9=XrbDSh1w@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
	<CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
	<CANeU7Q=tSY-CVCv=+CB80C7w4e5RjR=4ZWKNM92raWvKd_rz6g@mail.gmail.com>
	<CA+55aFz4mozGHRqV3YqkQEY5yqSrPSfVUbjPk7MNEt2ZBsvU_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:41052 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaDRG3k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Apr 2014 02:29:40 -0400
Received: by mail-qg0-f51.google.com with SMTP id q108so1354349qgd.38
        for <linux-sparse@vger.kernel.org>; Thu, 17 Apr 2014 23:29:39 -0700 (PDT)
In-Reply-To: <CA+55aFz4mozGHRqV3YqkQEY5yqSrPSfVUbjPk7MNEt2ZBsvU_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 1:21 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Ok, I think that is just us being too anal. We should allow multiple
> definitions for functions that are identical otherwise, but differ in
> the "inline".
>
> So I think that MOD_INLINE check in check_declaration() is wrong, and
> makes us consider the definitions to be for different symbols. Yes,
> that ignores the warning, but they really *aren't* different symbols.

I take a closer look to this MOD_INLINE check. That check is wrong
and should be removed.

However, still don't have a good way to fix duplicate extern inline check yet.
Here is what goes wrong when I remove the check

./sparse validation/extern-inline.c validation/extern-inline.c
validation/extern-inline.c:12:1: warning: multiple definitions for function 'g'
validation/extern-inline.c:12:1:  the previous one is here

The offending source code are:
extern int g(int);

extern __inline__ int
g(int x)
{
        return x;
}

Notice that the first extern int g(int) does not have inline? It get the
global scope. The second g has inline, it get the local scope.

However, the first global version of g() gets the declaration from
parse_function_body()

        while (prev) {
            prev->definition = decl;
            prev = prev->same_symbol;
        }

The extern-inline version of g() actually get removed when the file scope
ends. The extern version stays and it has the definition from the
extern-inline version. (BTW, there is a minor bug there the user of
the first global symbol will know nothing about inline, they are using
the global version on the extern inline version. I can give a test case
if needed)

So when we compile the extern-inline as the second file, sparse complain
that there are two g() has definition, the conflicting one is the first global
version of g(), the function body borrow from the inline version.

> So the correct thing to do is (I think) to remove that check, and then
> make the parse_function_body() warning go away by accepting the fact
> that we can have both an inline version and an out-of-line version of
> the same function.

Unfortunately, disable the warning is not the right fix. Because it will
allow extern-inline fuction to have two function body in the same file.
e.g.

extern __inline__ int g(int x) { return x; }
extern __inline__ int g(int x) { return x + 1; }

If we just silence the warning, sparse will not able to warn about this.

So it come back to the question:
When the file scope ends, why does the global symbol
still stays? end_file_scope() only removes the local file symbol,
not the global symbol define by the previous file.

When sparse compile the second file, it can still see the global
symbol left by the previous file. If the global symbol was removed,
this duplicate definition warning should go way as well.

Suggestion?

I am tempting to just revert the MOD_INLINE check and fix the
extern inline breakage in a different patch.

Chris
