From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v4 00/63] LLVM fixes
Date: Tue, 21 Mar 2017 13:36:50 +0000
Message-ID: <CACXZuxe8cg1QMnznpy8MCkZtsuG5mTd7zjZsapOupMk2jO+fAA@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <CACXZuxdcgnhBwnaS9nDqh47KrpkqEu11SB6FXGTebpBPZ1GZ-A@mail.gmail.com> <20170321130043.usyby3sfb6oiln6k@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34074 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCUNhl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 09:37:41 -0400
Received: by mail-io0-f179.google.com with SMTP id b140so48509052iof.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 06:36:51 -0700 (PDT)
In-Reply-To: <20170321130043.usyby3sfb6oiln6k@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Luc,

On 21 March 2017 at 13:00, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 21, 2017 at 11:24:57AM +0000, Dibyendu Majumdar wrote:
>> Thank you once again for posting this set of patches. I wanted to
>> understand what your approach is with testing of the LLVM backend in
>> general. The test cases that are currently present and also the new
>> ones you are adding do not appear to be runnable. Unless you are
>> saving expected LLVM IR output and comparing the test output with that
>> I think the tests do not prove that the generated code is correct.
>
> I'm not surprised at all that some of the test cases, new or old,
> are not runnable (I suppose that you mean that their execution
> produce wrong result).

I meant that they are not runnable as in you cannot run the compiled
output. Moreover the tests do not validate the expected results.

>
> It's a bit too early for me to look closely at the generated code,
> there was simply too much input code that caused crashes, triggered
> some asserts or produced type error in the LLVM IR. And it's not
> like everything is now solved regarding this.
>

Okay understand this.

> For the next steps, yes, it would certainly be needed to have tests
> for the correctness of the generated code. And by 'tests' I mean
> 'test cases suitable and present in sparse's test suite'.
> I was somehow expecting you will submit them/somes as you seem
> quite interested in sparse/LLVM.
>

Indeed I am and I have a bunch of tests in my repository that I run
everytime I change something. These tests are all runnable in the
sense mentioned above, and all are designed to validate that results
are as expected. I am happy to contribute these as I mentioned before
- but I am not sure of the process. Do I just submit patches? Are
there any specific needs for how the tests should be run?

I am very much interested in ensuring that as changes occur in sparse
they do not break things. While I will catch these breaks in my
repository it is better to catch them upstream.

Regards
Dibyendu
