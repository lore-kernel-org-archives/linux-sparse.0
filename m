From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Cast to double being removed
Date: Sat, 18 Mar 2017 01:30:00 +0000
Message-ID: <CACXZuxegR3CJK5m0UTXMO6P46W9r1P+iM4tP_NST8xDHSy=qjA@mail.gmail.com>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
 <CA+55aFxCqUY5k7=rmmfzW+=44+csM71bxcqqGJgLXqsg5C6F4Q@mail.gmail.com> <CACXZuxd_YRpyfTmubOczp7J8xgaXsW89H4TOk7OqhUJ6nU0cmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35501 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCRC3S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 22:29:18 -0400
Received: by mail-it0-f49.google.com with SMTP id m27so40975114iti.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 19:27:50 -0700 (PDT)
In-Reply-To: <CACXZuxd_YRpyfTmubOczp7J8xgaXsW89H4TOk7OqhUJ6nU0cmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 17 March 2017 at 10:38, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 17 March 2017 at 00:24, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> There's something seriously screwed up with explicit double casting.
>> See the differences between
>>
>>   double f1(void) { return -1; }
>>   double f2(void) { return (double)-1; }
>>   double f3(void) { return -1.0; }
>>
>> and notice how the first one and third ones actually kind-of make
>> sense. The second one? Not so much, it just uses a 64-bit integer.
>>
>> The bug is already at the parse tree stage, the linearization doesn't
>> even see the cast.
>>
>> I think it's this, in simplify_cast():
>>
>>         /* A cast of a constant? */
>>         if (constant(src)) {
>>                 int sign = orig_type->ctype.modifiers & MOD_SIGNED;
>>                 long long val = get_cast_value(src->value, orig_size,
>> size, sign);
>>                 src = value_pseudo(val);
>>                 goto simplify;
>>         }
>>
>> which doesn't even check whether it's a FP value, it just looks if
>> it's a constant and assumes it's an integer. At least it checks the
>> sign ;)
>>
>
> Thank you for pointing me to the location where the issue might be.
>

It seems that not only here but elsewhere also during simplification
of expressions involving constants there is no check whether the
instruction type is floating point. As a test I simply disabled the
simplification if the instruction type is floating point. Good news is
that while before the paranoia test was hanging and giving many
errors, but now it says:

No failures, defects nor flaws have been discovered.
Rounding appears to conform to the proposed IEEE standard P754.
The arithmetic diagnosed appears to be Excellent!
END OF TEST.

Regards
Dibyendu
