From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 11:26:56 -0800
Message-ID: <9b5a65f0-f411-206e-7973-3d38f06a7102@infradead.org>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com>
 <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
 <CANeU7QkQXoSO+wDDMUfsFuuhavt+YLZXiCCKuqNLTuq3aMc3rQ@mail.gmail.com>
 <a647d436-f31a-1475-b9d3-b445a02095f8@infradead.org>
 <CANeU7Q=qbo-kMduqM8Xws9WXvr89gt-thLrQLp7dox3O_VutLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33973 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeAXT07 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 14:26:59 -0500
In-Reply-To: <CANeU7Q=qbo-kMduqM8Xws9WXvr89gt-thLrQLp7dox3O_VutLw@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 01/24/2018 11:19 AM, Christopher Li wrote:
> On Tue, Jan 23, 2018 at 5:38 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>> diff --git a/validation/test-suite b/validation/test-suite
>>> index cf151a3..5e10942 100755
>>> --- a/validation/test-suite
>>> +++ b/validation/test-suite
>>> @@ -31,6 +31,7 @@ known_ko_tests=0
>>>
>>>  # defaults to not verbose
>>>  [ -z "$V" ] && V=0
>>> +[ $V -eq 0 ] && quiet=1 || quiet=0
>>>
>>>  ##
>>
>> Fine with me.
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>
> I consider that as a minor tweak of your original patch.
> May I apply that change and keep you as the author of the
> patch?

Sure, no problem.

Thanks.

-- 
~Randy
