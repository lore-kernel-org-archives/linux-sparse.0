From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 17:47:55 +0100
Message-ID: <CAExDi1QY4rHK7hdztfGyCYQd8KwW2aopxqL4FAe2P0bdsaNKKw@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CACXZuxd+SKSFxB5S0y9-bGep64_Vvpw3SvqDQqeKNzo3dtw_Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33130 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdB1Q5N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 11:57:13 -0500
Received: by mail-qk0-f178.google.com with SMTP id n127so27715253qkf.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 08:57:12 -0800 (PST)
In-Reply-To: <CACXZuxd+SKSFxB5S0y9-bGep64_Vvpw3SvqDQqeKNzo3dtw_Mg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 5:04 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 28 February 2017 at 15:09, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Feb 28, 2017 at 06:20:43AM +0000, Dibyendu Majumdar wrote:
>>> I am trying to debug a failure in sparse-llvm when compiling following:
>>>
>>> struct mytype {
>>>  int *foo;
>>> };
>>> extern void init_mytype(struct mytype *mt);
>>> void init_mytype(struct mytype *mt) {
>>>  mt->foo = (void *)0;
>>> }
>>>
>>
>> I think that the best you can do for us to be able to help you is to create
>> test case showing concretely the issues you have.
>>
>
> Above is a simple test case. If you use an LLVM build with assertions
> enabled then the code generator aborts:
>
> Assertion failed: getOperand(0)->getType() ==
> cast<PointerType>(getOperand(1)->getType())->getElementType() && "Ptr
> must be a pointer to Val type!", file
> C:\d\llvm-3.9.0.src\lib\IR\Instructions.cpp, line 1436

I had hoped that "sparse-llvm file.c | llvm-dis" would give a bit more info
but well ...

> In the details I posted I was trying to say that :
>
> a) The Expression Value does not appear to pass down the fact that it
> has found a NULL pointer - i.e. (void *)0.
> b) And even if this is conveyed (by making changes I suggested) then
> it is lost at the time of converting to value pseudo. As far as I can
> tell the cast is not being optimized away, it is just lost in
> translation.

OK. It would certainly be a good thing to show/look at the output of
test-linearize together with the C code and any info coming from
sparse-llvm (and llvm-dis) since this output is the readable form
of sparse-llvm's input.


Luc
