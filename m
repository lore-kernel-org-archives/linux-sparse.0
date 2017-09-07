From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-llvm question regarding handling of phi/phsrc instructions
Date: Thu, 7 Sep 2017 21:33:19 +0100
Message-ID: <CACXZuxexgWjzvvZC-YNbzfaGuLyB+ovkJcdAkkySN8FF13XsrA@mail.gmail.com>
References: <CACXZuxfKGmGEtOm8DOz=J9f77eSMyQGT8NRpc_6tEBncuJuy7A@mail.gmail.com>
 <CAExDi1RQ3HnnByw_y-jMpm1bH_yTMyQEVSLyCvGFzb8W9TpCXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34832 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdIGUdV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 16:33:21 -0400
Received: by mail-ua0-f171.google.com with SMTP id c27so1388884uah.2
        for <linux-sparse@vger.kernel.org>; Thu, 07 Sep 2017 13:33:20 -0700 (PDT)
In-Reply-To: <CAExDi1RQ3HnnByw_y-jMpm1bH_yTMyQEVSLyCvGFzb8W9TpCXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 September 2017 at 21:25, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> 2017-09-07 18:04 GMT+02:00 Dibyendu Majumdar <mobile@majumdar.org.uk>:
>> The following code snippet:
>>
>> static int test_do(void) {
>>     int a = 0;
>>     int count = 27;
>>     switch (count % 8) {
>>     case 0: do {  a++;
>>     case 7:       a++;
>>     case 6:       a++;
>>     case 5:       a++;
>>     case 4:       a++;
>>     case 3:       a++;
>>     case 2:       a++;
>>     case 1:       a++;
>>             } while ((count -= 8) > 0);
>>     }
>>     return a;
>> }
>>
>> Results in following linear output:
>>
>> test_do:
>> .L0:
>>         <entry-point>
>>         phisrc.32   %phi3(a) <- $0
>>         phisrc.32   %phi4(a) <- $0
>>         phisrc.32   %phi6(a) <- $0
>>         phisrc.32   %phi8(a) <- $0
>>         phisrc.32   %phi10(a) <- $0
>>         phisrc.32   %phi12(a) <- $0
>>         phisrc.32   %phi14(a) <- $0
>>         phisrc.32   %phi16(a) <- $0
>>         phisrc.32   %phi18(a) <- $0
>>         phisrc.32   %phi20(count) <- $27
>>         br          .L7
>>
>> .L10:
>>         phi.32      %r3 <- %phi18(a), %phi19(a)
>>         add.32      %r4 <- %r3, $1
>>         phisrc.32   %phi17(a) <- %r4
>>         phi.32      %r5 <- %phi16(a), %phi17(a)
>> ...
>>
>> This is translated to following LLVM IR:
>>
>> It seems to me that 'a' ends up having 9 different slots on the stack,
>> but it should really be merged into one slot, i.e. we should detect
>> that the phis all related to the same symbol, and create only one
>> alloca?
>
>
> Yes and no. It's just one of the problem with the SSA conversion
> as done in rc5.
> If you try the same code with newssa, you have something much
> saner, no?
>

Seems worse actually:

Here is a part of the linearized output pre simplifications. Note that
I haven't applied the fix you sent yesterday.

test_do:
.L0:
<entry-point>
mods.32     %r1 <- $27, $8
phisrc.32   %phi1(a) <- $0
phisrc.32   %phi3(a) <- $0
phisrc.32   %phi5(a) <- $0
phisrc.32   %phi7(a) <- $0
phisrc.32   %phi9(a) <- $0
phisrc.32   %phi11(a) <- $0
phisrc.32   %phi13(a) <- $0
phisrc.32   %phi15(count) <- $27
phisrc.32   %phi16(count) <- $27
phisrc.32   %phi17(count) <- $27
phisrc.32   %phi18(count) <- $27
phisrc.32   %phi19(count) <- $27
phisrc.32   %phi20(count) <- $27
phisrc.32   %phi21(count) <- $27
phisrc.32   %phi34(a) <- $0
switch.32   %r1, 0 -> .L2, 1 -> .L9, 2 -> .L8, 3 -> .L7, 4 -> .L6, 5
-> .L5, 6 -> .L4, 7 -> .L3, default -> .L1

.L2:
phisrc.32   %phi29(a) <- $0
phisrc.32   %phi31(count) <- $27
br          .L10
