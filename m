From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] univ-init: scalar initializer needs some additional
 checks
Date: Wed, 3 Jun 2020 14:47:04 +0100
Message-ID: <99851c7e-e96a-aa5d-9184-d6e17e31e3d3@ramsayjones.plus.com>
References: <20200602163336.32667-1-luc.vanoostenryck@gmail.com>
 <34e42c7f-6c9d-b8e5-6ee1-2988b1099176@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:36401 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCNrK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jun 2020 09:47:10 -0400
In-Reply-To: <34e42c7f-6c9d-b8e5-6ee1-2988b1099176@ramsayjones.plus.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 03/06/2020 02:01, Ramsay Jones wrote:

> On 02/06/2020 17:33, Luc Van Oostenryck wrote:
[snip]
> I applied this patch just now and everything worked fine. In addition,
> the tests from my patch also passed, once I had remembered to add the
> -Wno-universal-initializer to the 'check-command' - because I do not
> have the patch which changes the default for that warning.
> 
> The only thing which gave me pause ...
> 
>> Fixes: 537e3e2daebd37d69447e65535fc94e82b38fc18
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  evaluate.c                 |  3 +++
>>  expression.h               |  1 +
>>  parse.c                    | 15 ++++++++-------
>>  validation/Wuniv-init-ko.c | 16 ++++++++++++++++
>>  validation/Wuniv-init-ok.c | 18 ++++++++++++++++++
>>  5 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/evaluate.c b/evaluate.c
>> index 8d2e68692a48..16553eb3481b 100644
>> --- a/evaluate.c
>> +++ b/evaluate.c
>> @@ -2608,6 +2608,9 @@ static void handle_list_initializer(struct expression *expr,
>>  	struct expression *e, *last = NULL, *top = NULL, *next;
>>  	int jumped = 0;
>>  
>> +	if (expr->zero_init)
>> +		expr->expr_list = NULL;
> 
> ... was the potential memory leak here. (OK it wouldn't be a
> huge leak, but still!).

Heh, as soon as my head hit the pillow I realised that, due to extensive
use of memory pools/arenas, this is a rather silly comment! ;-)

[Ah, well, it was 2am!]

ATB,
Ramsay Jones
