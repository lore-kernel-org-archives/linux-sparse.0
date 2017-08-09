From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Wed, 9 Aug 2017 23:23:58 +0100
Message-ID: <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com> <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35525 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdHIWX7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 18:23:59 -0400
Received: by mail-vk0-f47.google.com with SMTP id d124so30904863vkf.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 15:23:59 -0700 (PDT)
In-Reply-To: <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

On 9 August 2017 at 21:02, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 9, 2017 at 9:47 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Hi Luc,
>>
>> This this change independent of the rest of changes in the series -
>> i.e. can I just apply this change?
>
> Absolutely.
>

Thank you. I am trying out this change as I am hoping it will help
avoid the incorrect simplifications we saw in some cases. So far my
findings are:

It solves the bit field access issue: i.e. this test works
(https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/onebit.c).

But it doesn't help with the issue with pseudos defined in one branch
of the code (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c).

Is there another fix / patch that you made to overcome above issue or
would you expect both issues to be fixed by this change?

I will run my test cases with this change and report if anything breaks.

Regards
Dibyendu
