From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 18:26:44 +0200
Message-ID: <CAExDi1QwKb+=LYmfw0cMHbjgZ8rVkojk2VWypg+kkCUkQTF0xA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CAExDi1RrEw4si8F9AEuHCrt9Zu7iDQ+btOysqciPVR=P-AQu4g@mail.gmail.com> <CANeU7Qkf4D9QQhWR1s5mkUCrWn3ze96VkajuMkOCJg_fZciNcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35422 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdHRQ0p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 12:26:45 -0400
Received: by mail-oi0-f51.google.com with SMTP id e124so101760116oig.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 09:26:45 -0700 (PDT)
In-Reply-To: <CANeU7Qkf4D9QQhWR1s5mkUCrWn3ze96VkajuMkOCJg_fZciNcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 6:13 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Note: it's not even 'what can be put in a pseudo(-register)'
>>           were selecting here. It's OK to have pseudos for
>>           'non-simple' values, They will just be transient and we
>>           won't be interested in their 'flow'.
>
> We need to be very careful about composite type pointer alias.

There are only pointer aliases if there are pointers. Here, we're only
interested in local variables.

But, and thanks to this remarks, I added a test and realized that
contrary to what I thought, the MOD_ADDRESSABLE is *not*
propagated from member to parent. So for the moment, I'll need
to drop this and only look at pure scalar variables. It's annoying.

-- Luc
