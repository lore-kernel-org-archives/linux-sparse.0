From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 16:04:27 +0000
Message-ID: <CACXZuxd+SKSFxB5S0y9-bGep64_Vvpw3SvqDQqeKNzo3dtw_Mg@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38084 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdB1QLc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 11:11:32 -0500
Received: by mail-it0-f50.google.com with SMTP id y135so12341624itc.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 08:11:27 -0800 (PST)
In-Reply-To: <20170228150956.moyfiyd5zf7tbeze@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hi Luc,

On 28 February 2017 at 15:09, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Feb 28, 2017 at 06:20:43AM +0000, Dibyendu Majumdar wrote:
>> I am trying to debug a failure in sparse-llvm when compiling following:
>>
>> struct mytype {
>>  int *foo;
>> };
>> extern void init_mytype(struct mytype *mt);
>> void init_mytype(struct mytype *mt) {
>>  mt->foo = (void *)0;
>> }
>>
>
> I think that the best you can do for us to be able to help you is to create
> test case showing concretely the issues you have.
>

Above is a simple test case. If you use an LLVM build with assertions
enabled then the code generator aborts:

Assertion failed: getOperand(0)->getType() ==
cast<PointerType>(getOperand(1)->getType())->getElementType() && "Ptr
must be a pointer to Val type!", file
C:\d\llvm-3.9.0.src\lib\IR\Instructions.cpp, line 1436

In the details I posted I was trying to say that :

a) The Expression Value does not appear to pass down the fact that it
has found a NULL pointer - i.e. (void *)0.
b) And even if this is conveyed (by making changes I suggested) then
it is lost at the time of converting to value pseudo. As far as I can
tell the cast is not being optimized away, it is just lost in
translation.

I could be wrong in my analysis as I mentioned before. I will try to
generate some debug info to further show what seems to be happening.

Regards
Dibyendu
