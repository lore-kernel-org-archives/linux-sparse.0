From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-llvm question regarding handling of phi/phsrc instructions
Date: Fri, 8 Sep 2017 11:11:08 +0100
Message-ID: <CACXZuxebbu2h4iSXduwaBVxLaubj_ZSnp_c8_tZncRfK5DbpWA@mail.gmail.com>
References: <CACXZuxfKGmGEtOm8DOz=J9f77eSMyQGT8NRpc_6tEBncuJuy7A@mail.gmail.com>
 <CAExDi1RQ3HnnByw_y-jMpm1bH_yTMyQEVSLyCvGFzb8W9TpCXA@mail.gmail.com> <CACXZuxexgWjzvvZC-YNbzfaGuLyB+ovkJcdAkkySN8FF13XsrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:32874 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdIHKLJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Sep 2017 06:11:09 -0400
Received: by mail-vk0-f52.google.com with SMTP id t10so2915837vke.0
        for <linux-sparse@vger.kernel.org>; Fri, 08 Sep 2017 03:11:09 -0700 (PDT)
In-Reply-To: <CACXZuxexgWjzvvZC-YNbzfaGuLyB+ovkJcdAkkySN8FF13XsrA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 7 September 2017 at 21:33, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 7 September 2017 at 21:25, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> 2017-09-07 18:04 GMT+02:00 Dibyendu Majumdar <mobile@majumdar.org.uk>:
>>> The following code snippet:
>>>
>>> static int test_do(void) {
>>>     int a = 0;
>>>     int count = 27;
>>>     switch (count % 8) {
>>>     case 0: do {  a++;
>>>     case 7:       a++;
>>>     case 6:       a++;
>>>     case 5:       a++;
>>>     case 4:       a++;
>>>     case 3:       a++;
>>>     case 2:       a++;
>>>     case 1:       a++;
>>>             } while ((count -= 8) > 0);
>>>     }
>>>     return a;
>>> }
>>>
>>> Results in following linear output:
>>>
>>> test_do:
>>> .L0:
>>>         <entry-point>
>>>         phisrc.32   %phi3(a) <- $0
>>>         phisrc.32   %phi4(a) <- $0
>>>         phisrc.32   %phi6(a) <- $0
>>>         phisrc.32   %phi8(a) <- $0
>>>         phisrc.32   %phi10(a) <- $0
>>>         phisrc.32   %phi12(a) <- $0
>>>         phisrc.32   %phi14(a) <- $0
>>>         phisrc.32   %phi16(a) <- $0
>>>         phisrc.32   %phi18(a) <- $0
>>>         phisrc.32   %phi20(count) <- $27
>>>         br          .L7
>>>
>>> .L10:
>>>         phi.32      %r3 <- %phi18(a), %phi19(a)
>>>         add.32      %r4 <- %r3, $1
>>>         phisrc.32   %phi17(a) <- %r4
>>>         phi.32      %r5 <- %phi16(a), %phi17(a)
>>> ...
>>>
>>> It seems to me that 'a' ends up having 9 different slots on the stack,
>>> but it should really be merged into one slot, i.e. we should detect
>>> that the phis all related to the same symbol, and create only one
>>> alloca?
>>
>>

What is also interesting is that in the old way by switching off the
simplifications the generated code avoids all the phis and is actually
simpler in terms of memory operations in the backend. Now LLVM can
sort this out easily as it transforms this to use phis anyway, but my
other backend is simpler, and for that non SSA version is better.

Regards
Dibyendu
