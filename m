From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 22:59:39 -0700
Message-ID: <CANeU7Q==Uw7KybSExx7G60tAi8gqOh+L-=TEZd=VKSM0=saw+g@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
	<CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
	<CANeU7Q=tSY-CVCv=+CB80C7w4e5RjR=4ZWKNM92raWvKd_rz6g@mail.gmail.com>
	<CA+55aFz4mozGHRqV3YqkQEY5yqSrPSfVUbjPk7MNEt2ZBsvU_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:48657 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaCaF7k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Mar 2014 01:59:40 -0400
Received: by mail-qg0-f46.google.com with SMTP id 63so3376960qgz.33
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 22:59:40 -0700 (PDT)
In-Reply-To: <CA+55aFz4mozGHRqV3YqkQEY5yqSrPSfVUbjPk7MNEt2ZBsvU_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 1:21 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Mar 30, 2014 at 12:22 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Possible. If I comment out that check, I will get this error in the
>> extern-inline.c
>> test case:
>>
>> $ ./sparse validation/extern-inline.c validation/extern-inline.c
>> validation/extern-inline.c:12:1: warning: multiple definitions for function 'g'
>> validation/extern-inline.c:12:1:  the previous one is here
>
> Ok, I think that is just us being too anal. We should allow multiple
> definitions for functions that are identical otherwise, but differ in
> the "inline".

The difference is not only in "inline", but also the different function body
declared in two different files. The better example should be
./sparse validations/extern-inlineA.c validations/extern-inlineB.c

where inlineA.c and inlineB.c has different implementation of function 'g'.
Same function prototype of 'g', just different function body in different files.

In other words, we should treat extern inline has the same file visibility
as static inline. The only difference is that, when compiler can't inline
the function, extern inline assume the function has external copy and
don't generate the local copy. Static inline turn the function into
a static function.


>
> So the correct thing to do is (I think) to remove that check, and then
> make the parse_function_body() warning go away by accepting the fact
> that we can have both an inline version and an out-of-line version of
> the same function.

I agree we should remove that MOD_INLINE check and fix the warning else
where. The warning is actually not about inline version vs out-of-line version.
It is about two files have two different implementation of the inline version.

Let me take a stab on that. My guess is that, I can fix it by treating
extern inline
like static inline, remove the symbol when the file scope ends. Then the
second file will not see it and complain the duplicate symbol. Haven't verify
that works or not yet.

Chris
