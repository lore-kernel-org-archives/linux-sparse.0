From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 18:29:30 +0200
Message-ID: <CAExDi1Tttfz0Djxq16q=PXC2wmWJ+nZMbpD5no2744-QP20iRA@mail.gmail.com>
References: <20170503165518.7625-1-lrichard@redhat.com> <20170503235403.6i5za2wa526fmp6w@desk.local>
 <CAMHZB6Gjf5gX92yiGshRgCpCLM=xuxBkXyDQ=RQA=gx6bG3PpQ@mail.gmail.com>
 <1089027793.4868687.1493906030607.JavaMail.zimbra@redhat.com>
 <20170504145834.mef3psritw2lxf35@ltop.local> <99956653.4916117.1493912815498.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36338 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbdEDQ3b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 12:29:31 -0400
Received: by mail-qt0-f180.google.com with SMTP id m91so14522809qte.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 09:29:31 -0700 (PDT)
In-Reply-To: <99956653.4916117.1493912815498.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 4, 2017 at 5:46 PM, Lance Richardson <lrichard@redhat.com> wrote:
>> From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
>> To: "Lance Richardson" <lrichard@redhat.com>
>> Cc: "Linux-Sparse" <linux-sparse@vger.kernel.org>
>> Sent: Thursday, 4 May, 2017 10:58:35 AM
>> Subject: Re: [PATCH v4] sparse: add support for _Static_assert
>>
>> On Thu, May 04, 2017 at 09:53:50AM -0400, Lance Richardson wrote:
>> > Thanks for the quick feedback, will incorporate in v5.
>>
>> I also saw a small issue, possibly related to the problem with
>> the mixup between 'declaration-list' and 'struct-declarator-list'
>> that you noticed. In the following code, the static assert is not
>> recognized:
>>       void foo(void)
>>       {
>>               int i = 0;
>>               for (_Static_assert(1, "ok"); 1; )
>>                       ;
>>               for (_Static_assert(0, "ko"); 1; )
>>                       ;
>>       }
>>
>> It should because (since C99) the first part of the for-statement
>> is just a 'declaration', which include the static assert.
>> Not that it's very important, though.
>>
>> Probably, it's best to leave it as is for the moment and just
>> add a new test case, annotated with 'check-known-to-fail'.
>>
>> -- Luc
>>
>
> Hi Luc,
>
> I'm not sure it should be accepted; the standard doc says:
>
>     "The declaration part of a for statement shall only declare
>      identifiers for objects having storage class auto or register."
>
> But _Static_assert() doesn't declare an identifier.

Indeed.

> gcc accepts this syntax, although clang does not.  I did find this discussion:
>
>     https://reviews.llvm.org/D9113
>
> Which points to a working group discussion that made it sound as
> though _Static_assert() should not be accepted in for-loop declarations:

It makes a lot of sense to not accept it.

>     www.open-std.org/JTC1/SC22/WG14/13677
>
> As you say, probably best to leave this for now.

Yes, even more so now.
Thanks for the info.

-- Luc
