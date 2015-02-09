From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent
 string litterals
Date: Mon, 9 Feb 2015 21:48:52 +0000
Message-ID: <CAGrt=7hURQi_h823pZ-cXCbqdwDkFQSA1QDuduXCt=oaZaeDdA@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
	<87r3u6ax5f.fsf@rasmusvillemoes.dk>
	<87mw4uaw8x.fsf@rasmusvillemoes.dk>
	<CANeU7QmHRFMhYeeyQm=8MYs=C1B=qo8vn8DN=4zUPo8j8rZUow@mail.gmail.com>
	<874mqypv10.fsf@rasmusvillemoes.dk>
	<CANeU7QniCPHPqvJe=xnA7yAUADm_3Z8oZLtNtoejgAfv-kcdBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:61452 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761489AbbBIVsx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Feb 2015 16:48:53 -0500
Received: by mail-vc0-f175.google.com with SMTP id hq12so3331343vcb.6
        for <linux-sparse@vger.kernel.org>; Mon, 09 Feb 2015 13:48:52 -0800 (PST)
In-Reply-To: <CANeU7QniCPHPqvJe=xnA7yAUADm_3Z8oZLtNtoejgAfv-kcdBQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 February 2015 at 01:30, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Feb 6, 2015 at 1:52 PM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>> Can you submit a patch for adding the test case you found?
>>> I will include those into the the test suit.
>>
>> I'd like to, but I'm not sure how to write the test in terms of sparse's
>> test frame work. How do I check that the string is as expected?
>
> You can use ./test-parsing to evaluate the test file.

There's even a bit of documentation!

http://git.kernel.org/cgit/devel/sparse/sparse.git/tree/Documentation/test-suite

-- 
Damien
