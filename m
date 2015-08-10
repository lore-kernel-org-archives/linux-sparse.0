From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 1/3 v2] .gitignore: add cscope and Qt project files
Date: Mon, 10 Aug 2015 07:18:30 -0400
Message-ID: <55C88886.9020903@redhat.com>
References: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
 <1438623660-18026-1-git-send-email-tcamuso@redhat.com>
 <CANeU7Q=_+QH3gxvbkptqMh2uQEoRRoECXeQyR+esAKvS4iAHGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933271AbbHJLSb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Aug 2015 07:18:31 -0400
In-Reply-To: <CANeU7Q=_+QH3gxvbkptqMh2uQEoRRoECXeQyR+esAKvS4iAHGw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 08/07/2015 11:58 PM, Christopher Li wrote:
> On Mon, Aug 3, 2015 at 1:41 PM, Tony Camuso <tcamuso@redhat.com> wrote:
>>
>> Signed-off-by: Tony Camuso <tcamuso@redhat.com>
>> ---
>>   .gitignore | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index d32d063..1e35eac 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -9,6 +9,7 @@
>>   pre-process.h
>>   sparse.pc
>>   version.h
>> +cscope*
>
>
> Can we be more specific on the cscope files?
> e.g. Will cscope.* works for you?
>
> Just in case we can have some C file which starts
> with "cscope". We do have "ctags.c" for example.
>
> Chris
>

Yes, very good point. You also have scope.c and scope.h

cscope.out is the generated file, so I will correct this patch
for that.

Regards,
Tony

