From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] Documents: project ideas
Date: Thu, 10 Aug 2017 15:46:38 -0400
Message-ID: <CANeU7QnvJy1uc3Kjpaq8170QmhrEAdo+P2WZqcSw5ys9F8cF5g@mail.gmail.com>
References: <CANeU7Qm5czpkmaswwhqyXZn95-eeU-7SM6+uEUBqUh64oEVRKQ@mail.gmail.com>
 <9cc6504c-fa18-3b6a-132b-5797551d48ac@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36767 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbdHJTqj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 15:46:39 -0400
Received: by mail-yw0-f193.google.com with SMTP id n83so1062251ywn.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 12:46:39 -0700 (PDT)
In-Reply-To: <9cc6504c-fa18-3b6a-132b-5797551d48ac@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 10, 2017 at 3:42 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 08/09/2017 08:30 PM, Christopher Li wrote:
>> Adding project idea to improve sparse.
>>
>> Signed-off-by: Christopher Li <sparse@chrisli.org>
>> ---
>>  Documentation/project-ideas.md | 52 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/project-ideas.md
>>
>> diff --git a/Documentation/project-ideas.md b/Documentation/project-ideas.md
>> new file mode 100644
>> index 0000000..9adce20
>> --- /dev/null
>> +++ b/Documentation/project-ideas.md
>> @@ -0,0 +1,52 @@
>> +Why hacking on sparse
>> +=====================
>> +
>> +1. sparse is small.
>> +   The full project compiles in less than * seconds on old and not
>> performing laptop.
>> +2. sparse is fast.
>> +   Typically, sparse can check on C file ** of time it take for gcc
>
>                         can check a C file in ** of the time it takes for gcc
>
>> to generate object files.
>> +3. sparse can digest the full kernel source file.
>
>                                                files.

Thanks you so much.

Will send out V2 soon.

Chris
