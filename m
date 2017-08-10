From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] Adding document for sparse patch submit process
Date: Thu, 10 Aug 2017 15:45:33 -0400
Message-ID: <CANeU7Q=Rbtxm_3-cjGGGoVA3YksB1CP4tX6QDuOAgzmEJ_JEEw@mail.gmail.com>
References: <CANeU7Qm9+-++i6U9DYXn-NYVj-k4r63JkK3srESyboTxQiP=4g@mail.gmail.com>
 <3b19a3d1-83d0-ce26-e7fc-4fb87052c8bd@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35011 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdHJTpe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 15:45:34 -0400
Received: by mail-yw0-f193.google.com with SMTP id l82so1057480ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 12:45:34 -0700 (PDT)
In-Reply-To: <3b19a3d1-83d0-ce26-e7fc-4fb87052c8bd@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 10, 2017 at 3:36 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 08/09/2017 08:27 PM, Christopher Li wrote:
>> Reference to the linux kernel patches submitting process
>> and difference to sparse.
>>
>> Signed-off-by: Christopher Li <sparse@chrisli.org>
>> ---
>>  Documentation/submitting-patches.md | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/submitting-patches.md
>>
>> diff --git a/Documentation/submitting-patches.md
>> b/Documentation/submitting-patches.md
>> new file mode 100644
>> index 0000000..f526d44
>> --- /dev/null
>> +++ b/Documentation/submitting-patches.md
>> @@ -0,0 +1,21 @@
>> +Submitting patches: the sparse version
>> +======================================
>> +
>> +Sparse use a patch submit process similar to the Linux Kernel
>
>           uses

Great Great.

That is exactly the feed back I need :-)

I will incarcerate your feed back and send out an update very soon.


>
>> +
>> +2. Sign off the patch.
>
> 3. instead of 2. ??

Yes, I can use 3.  The exact number does not matter to MD parsing,
but using 3 will make the reader less confusing.

Chris
