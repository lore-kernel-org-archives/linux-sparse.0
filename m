From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Tue, 23 Jan 2018 10:20:55 -0800
Message-ID: <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeAWSVB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Jan 2018 13:21:01 -0500
In-Reply-To: <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 01/23/2018 03:22 AM, Christopher Li wrote:
> On Mon, Jan 22, 2018 at 11:05 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> In error(), quiet is undefined when the command:
>>   $ ./test-suite format filename1.c foobar1
>>
>> is used and filename1.c does not exist. This causes a shell script error:
>>   ./test-suite: line 147: [: : integer expression expected
>>
>> because $quiet is undefined in
>>   [ "$quiet" -ne 1 ] && echo "error: $1"
>> so the error message is lost.
>>
>> Just initialize quiet before any command line parsing.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  validation/test-suite |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- sprs.orig/validation/test-suite
>> +++ sprs.next/validation/test-suite
>> @@ -368,6 +368,8 @@ arg_file()
>>         return 0
>>  }
>>
>> +quiet=0
>> +
> 
> Good catch. I think this fix is not ideal.
> There is another quite=0 inside "do_test()".
> <quote>
> quiet=0
> [ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
> </quote>
> 
> The "quite=0" only cover the case inside "do_test()".
> Even with this patch,  If  the "quite" is used outside of
> "do_test()", The "quite" variable is not set properly according to "V".
> 
> I would suggest move the above two quote line out side
> of "do_test()", right after the default value of "V", in the
> beginning of the file:
> 
> <quote>
> # defaults to not verbose
> [ -z "$V" ] && V=0
> </quote>

At the beginning of the file, $must_fail is not defined, so it will not -eq 1,
so quiet will remain = 0.

I guess that I don't understand the interplay between $V and $quiet and why
have both of them.

Are you suggesting that $quiet should be initialized by default like this:
(just drop the $must_fail part)

> quiet=0
> [ $V -eq 0 ] && quiet=1


thanks,
-- 
~Randy
