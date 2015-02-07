From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent
 string litterals
Date: Fri, 6 Feb 2015 17:30:50 -0800
Message-ID: <CANeU7QniCPHPqvJe=xnA7yAUADm_3Z8oZLtNtoejgAfv-kcdBQ@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
	<87r3u6ax5f.fsf@rasmusvillemoes.dk>
	<87mw4uaw8x.fsf@rasmusvillemoes.dk>
	<CANeU7QmHRFMhYeeyQm=8MYs=C1B=qo8vn8DN=4zUPo8j8rZUow@mail.gmail.com>
	<874mqypv10.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59391 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbbBGBav (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2015 20:30:51 -0500
Received: by mail-qc0-f181.google.com with SMTP id l6so14862570qcy.12
        for <linux-sparse@vger.kernel.org>; Fri, 06 Feb 2015 17:30:50 -0800 (PST)
In-Reply-To: <874mqypv10.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 6, 2015 at 1:52 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>> Can you submit a patch for adding the test case you found?
>> I will include those into the the test suit.
>
> I'd like to, but I'm not sure how to write the test in terms of sparse's
> test frame work. How do I check that the string is as expected?

You can use ./test-parsing to evaluate the test file.
$ cat /tmp/v.c
#define BACKSLASH "\\"
static const char a[] = BACKSLASH "a";
static const char b[] = BACKSLASH "b";

# on current master branch it shows:
$ ./test-parsing /tmp/v.c
.align 1
char static const [toplevel] a[0]
 =
    movi.64        v2,&"\7b"
    ld.24        v3,[v2]
,
.align 1
char static const [toplevel] b[0]
 =
    movi.64        v5,&"\7b"
    ld.24        v6,[v5]


# on the review-immutable-string branch it shows:
$ ./test-parsing /tmp/v.c

.align 1
char static const [toplevel] a[0]
 =
    movi.64        v2,&"\\a"
    ld.24        v3,[v2]
,
.align 1
char static const [toplevel] b[0]
 =
    movi.64        v5,&"\\b"
    ld.24        v6,[v5]


Notice that "\\a" and "\\b" was not there before the
bug was fixed.

The test suit is just some C file in the "validations" directory.
Each file has a test name and optional how to invoke the C file
and what to expect from the running result.
You should able to find some example in the test suit.
Or, you can just submit a patch to include those C file
in the "validations" directory. Let some one help you complete
the test suit.

You run the test suit as:

make check


Chris
