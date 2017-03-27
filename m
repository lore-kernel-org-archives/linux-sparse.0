From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 16:27:28 +0100
Message-ID: <444abf20-b5ef-664a-fed4-ebfd8969e1da@ramsayjones.plus.com>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
 <20170327010342.vd34svh3kee43qir@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:39200 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdC0P1h (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 11:27:37 -0400
In-Reply-To: <20170327010342.vd34svh3kee43qir@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 27/03/17 02:03, Luc Van Oostenryck wrote:
> On Sun, Mar 26, 2017 at 11:21:44PM +0100, Ramsay Jones wrote:
>> Hi Christopher, Luc,
>>
>> On occasion I build sparse on 32-bit Linux and I have noticed, for some
>> weeks now, unexpected test failures. I have been meaning to take a look
>> at fixing these failures, but I just haven't had the time ... :(
> 
>>   ...
>>   
>>        TEST     division constants (div.c)
>>   error: actual error text does not match expected error text.
>>   error: see div.c.error.* for further investigation.
>>   --- div.c.error.expected	2017-03-26 18:26:04.142887258 +0100
>>   +++ div.c.error.got	2017-03-26 18:26:04.142887258 +0100
>>   @@ -2,8 +2,6 @@
>>    div.c:4:20: warning: division by zero
>>    div.c:5:22: warning: division by zero
>>    div.c:7:25: warning: constant integer operation overflow
>>   -div.c:8:27: warning: constant integer operation overflow
>>    div.c:9:34: warning: constant integer operation overflow
>>    div.c:11:25: warning: constant integer operation overflow
>>   -div.c:12:27: warning: constant integer operation overflow
>>    div.c:13:34: warning: constant integer operation overflow
>>   ...
> 
> It's not very clear to me what is the cause of this error.
> Have you only since some weeks (then I think it's since the
> we define __SIZEOF_POINTER__) or is it older (then I think
> it exists since quite a long time)?

I just did a git bisect, which shows:

...

$ git bisect good
8d688c9a6ee220ce00b30afd8bdffa34434c9950 is the first bad commit
commit 8d688c9a6ee220ce00b30afd8bdffa34434c9950
Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Tue Feb 7 21:04:24 2017 +0100

    define __LONG_MAX__ & __SIZEOF_POINTER__
    
    They're part of GCC's common predefined macros and some
    code & header files depends on them.
    
    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    Signed-off-by: Christopher Li <sparse@chrisli.org>

:100644 100644 38ff165b360525c2b83cd76d674593ee79cb9ffb 65887c40d3b5b020991be2372b0af5c1b7088776 M	lib.c
$ 

So, I looked in the debugger and 'bits_in_long' and 'bits_in_pointer'
are set correctly, but __LONG_MAX__ is being printed with an LL suffix,
so, this fixes it for me:

$ git diff
diff --git a/lib.c b/lib.c
index 272d2c8..502c264 100644
--- a/lib.c
+++ b/lib.c
@@ -834,7 +834,7 @@ static void predefined_macros(void)
        add_pre_buffer("#define __CHECKER__ 1\n");
 
        val = (1ULL << (bits_in_long-1)) - 1;
-       add_pre_buffer("#weak_define __LONG_MAX__ %#llxLL\n", val);
+       add_pre_buffer("#weak_define __LONG_MAX__ %#llxL\n", val);
        add_pre_buffer("#weak_define __SIZEOF_POINTER__ %d\n", bits_in_pointer/8);
 }
 
$ 

Not a proper fix, but ...

Ah, I've just noticed you have sent some patches. ;-)

I will take a look and let you know.

ATB,
Ramsay Jones


